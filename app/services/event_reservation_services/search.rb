class EventReservationServices::Search < ApplicationService
  attr_reader :params

  def initialize(params)
    @user_id = params[:user_id]
    @event_id = params[:event_id]
  end

  def call
    @event_reservations = EventReservation.all

    @event_reservations = @event_reservations.where(user_id: @user_id) if @user_id.present?
    @event_reservations = @event_reservations.where(event_id: @event_id) if @event_id.present?
    return @event_reservations
  end
end
