class Api::V1::Front::EventReservationsController < ApplicationController
  before_action :authorize_request, except: %i[check_reserved_user]
  before_action :filter_params, only: %i[index]
  before_action :find_event_reservation, only: %i[show]

  def index
    @event_reservations = EventReservationServices::Search.call(filter_params)
    render json: @event_reservations, each_serializer: EventReservationSerializer, status: :ok
  end

  def show
    render json: @event_reservation, status: :ok
  end

  def charge
    @event = Event.find(params[:event_id])
    qr_code_link = QrcodeService.generate_qr_aws_image("#{ENV["FRONT_APP_URL"]}/event/#{params[:event_id]}/reserve/check?user_id=#{params[:user_id]}")

    intent = StripeServices::SetupIntent.create(params[:stripe_token], params[:user_id])

    @event_reservation = EventReservation.new(
      event_id: params[:event_id],
      user_id: params[:user_id],
      qr_code: qr_code_link,
      sub_total: @event.price,
      total: @event.price,
    )

    if @event_reservation.save
      EventReservationServices::SetupPayment.call(@event_reservation)
      @event_reservation.status_waiting!

      # Send the reservation detail to the customer
      EventReservationMailer.with(:event_reservation => @event_reservation).user_email_confirm.deliver_later
      # Send the reservation detail to the event owner
      EventReservationMailer.with(:event_reservation => @event_reservation).event_owner_email_confirm.deliver_later

      render json: intent, status: :created
    else
      render json: { errors: @event_reservation.errors.full_messages },
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

  def check_user_reserved
    @event_reservation = EventReservation.where(event_id: params[:event_id], user_id: params[:user_id])
    render json: { check: @event_reservation.present? }, status: :ok
  end

  def orders
    @event_reservations = EventReservation.filter_by_event_owner(params[:owner_id]) if params[:owner_id].present?
    render json: @event_reservations, each_serializer: EventReservationSerializer, status: :ok
  end

  private

  def find_event_reservation
    @event_reservation = EventReservation.find(params[:id])
  end

  def filter_params
    params.slice(:user_id, :event_id)
  end
end
