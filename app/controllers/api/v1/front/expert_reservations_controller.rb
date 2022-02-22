class Api::V1::Front::ExpertReservationsController < ApplicationController
  before_action :authorize_request, except: %i[checkout]
  before_action :find_reservation, only: %i[show approve]
  before_action :reserve_params, only: %i[charge]
  before_action :filter_params, only: %i[index]

  def index
    @expert_reservations = ExpertReservationServices::Search.call(filter_params)
    render json: @expert_reservations, each_serializer: ExpertReservationSerializer, status: :ok
  end

  def show
    render json: @expert_reservation, status: :ok
  end

  def checkout
    @expert = Expert.find(params[:expert_id])
    checkout = ExpertReservationServices::Checkout.call(@expert, params[:reserve_from], params[:reserve_to])
    render json: { :expert => ExpertSerializer.new(@expert).as_json, :checkout => checkout }, status: :ok
  end

  def charge
    @expert = Expert.find(reserve_params[:expert_id])
    checkout = ExpertReservationServices::Checkout.call(@expert, params[:reserve_from], params[:reserve_to])

    @expert_reservation = ExpertReservation.new(reserve_params.merge(checkout))

    intent = StripeServices::SetupIntent.create(params[:stripe_token], reserve_params[:user_id])

    if @expert_reservation.save
      # Setup payment Job
      ExpertReservationServices::SetupPayment.call(@expert_reservation)
      @expert_reservation.status_waiting!

      # Send the reservation details to the customer
      ExpertReservationMailer.with(:expert_reservation => @expert_reservation).user_email_confirm.deliver_later
      # Send the reservation details to the space owner
      ExpertReservationMailer.with(:expert_reservation => @expert_reservation).expert_email_confirm.deliver_later

      render json: intent, status: :created
    else
      render json: { errors: @expert_reservation.errors.full_messages },
             status: :unprocessable_entity
    end
  rescue Stripe::CardError => e
    # https://stripe.com/docs/api/errors/handling
    logger.info e
    render json: { error: e.error.message }, status: :bad_gateway
  rescue Stripe::StripeError => e
    # Display a very generic error to the user, and maybe send yourself an email
    logger.info e
    render json: { error: e.error.message }, status: :bad_gateway
  rescue => e
    logger.info e
    render json: { error: e }, status: :unprocessable_entity
  end

  def approve
    @expert_reservation.update(approved: 1)
    render json: @expert_reservation, status: :ok
  end

  def orders
    @event_reservations = ExpertReservation.filter_by_expert_user(params[:expert_user_id]) if params[:expert_user_id].present?
    render json: @event_reservations, each_serializer: ExpertReservationSerializer, status: :ok
  end

  def disabled_dates
    @reserved_dates = ExpertReservation.where("expert_id = ? AND (reserve_from > ? OR reserve_to > ?)", params[:expert_id].to_i, DateTime.now, DateTime.now).pluck(:reserve_from, :reserve_to) if params[:expert_id].present?
    @disabled_dates = Array.new
    @reserved_dates.each do |date|
      @disabled_dates = (@disabled_dates + date).uniq
    end
    render json: @disabled_dates, root: "disabled_dates", status: :ok
  end

  private

  def find_reservation
    @expert_reservation = ExpertReservation.find(params[:id])
  end

  def reserve_params
    params.require(:expert_reservation).permit(:user_id, :expert_id, :location, :people, :children, :category_id, :description, :reserve_from, :reserve_to)
  end

  def filter_params
    params.slice(:user_id, :expert_id, :category_id, :reserve_from, :reserve_to)
  end
end
