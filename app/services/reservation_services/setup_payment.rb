class ReservationServices::SetupPayment < ApplicationService
  attr_reader :reservation

  def initialize(reservation)
    @reservation = reservation
  end

  def call
    ReservationCheckoutJob.set(wait_until: @reservation.payment_exec_time).perform_later(@reservation)
  end
end
