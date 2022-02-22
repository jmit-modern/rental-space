class Api::V1::Front::ReservationsController < ApplicationController
  before_action :authorize_request, except: %i[checkout disabled_dates]
  before_action :find_reservation, only: %i[show approve]
  before_action :checkout_params, only: %i[checkout]
  before_action :reserve_params, only: %i[charge]
  before_action :filter_params, only: %i[index]

  def index
    @reservations = ReservationServices::Search.call(filter_params)
    render json: @reservations, each_serializer: ReservationSerializer, status: :ok
  end

  def show
    render json: @reservation, status: :ok
  end

  def checkout
    @space = Space.find(params[:space_id])
    @plan = SpacePlan.find(params[:plan_id])
    checkout = ReservationServices::Checkout.call(@plan, params[:reserve_from], params[:reserve_to])
    render json: { :space => SpaceSerializer.new(@space).as_json, :plan => @plan, :checkout => checkout }, status: :ok
  end

  def new
    @reservation = Reservation.new
    @reservation.build_reservation_detail
  end

  def charge
    @plan = SpacePlan.find(reserve_params[:plan_id])
    checkout = ReservationServices::Checkout.call(@plan, params[:reserve_from], params[:reserve_to])

    @reservation = Reservation.new(reserve_params.merge(checkout))

    intent = StripeServices::SetupIntent.create(params[:stripe_token], reserve_params[:user_id])

    if @reservation.save
      # Setup payment Job
      ReservationServices::SetupPayment.call(@reservation)
      # Change the status to waiting
      @reservation.status_waiting!

      # Send the reservation details to the customer
      ReservationMailer.with(:reservation => @reservation).user_email_confirm.deliver_later
      # Send the reservation details to the space owner
      ReservationMailer.with(:reservation => @reservation).expert_email_confirm.deliver_later

      render json: intent, status: :created
    else
      render json: { errors: @reservation.errors.full_messages },
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
    @reservation.update(approved: 1)
    # Send the reservation details to the space owner
    ReservationMailer.with(:reservation => @reservation).user_email_approved.deliver_later
    render json: @reservation, status: :ok
  end

  def orders
    @reservations = Reservation.filter_by_space_owner(params[:owner_id]) if params[:owner_id].present?
    render json: @reservations, each_serializer: ReservationSerializer, status: :ok
  end

  def disabled_dates
    @reserved_dates = Reservation.where("space_id = ? AND (reserve_from > ? OR reserve_to > ?)", params[:space_id].to_i, DateTime.now, DateTime.now).pluck(:reserve_from, :reserve_to) if params[:space_id].present?
    @disabled_dates = Array.new
    @reserved_dates.each do |date|
      @disabled_dates = (@disabled_dates + date).uniq
    end
    render json: @disabled_dates, root: "disabled_dates", status: :ok
  end

  private

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end

  def checkout_params
    params.require([:space_id, :plan_id, :reserve_from, :reserve_to])
  end

  def reserve_params
    params.require(:reservation).permit(:user_id, :space_id, :plan_id, :people, :children, :category_id, :description, :reserve_from, :reserve_to)
  end

  def filter_params
    params.slice(:user_id, :space_id, :plan_id, :category_id, :reserve_from, :reserve_to)
  end
end
