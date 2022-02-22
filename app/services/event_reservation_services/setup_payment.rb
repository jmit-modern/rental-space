class EventReservationServices::SetupPayment < ApplicationService
  attr_reader :event_reservation

  def initialize(event_reservation)
    @event_reservation = event_reservation
  end

  def call
    EventReservationCheckoutJob.set(wait_until: @event_reservation.payment_exec_time).perform_later(@event_reservation)
  end
end
