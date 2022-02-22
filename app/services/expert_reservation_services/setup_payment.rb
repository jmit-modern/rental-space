class ExpertReservationServices::SetupPayment < ApplicationService
  attr_reader :expert_reservation

  def initialize(expert_reservation)
    @expert_reservation = expert_reservation
  end

  def call
    ExpertReservationCheckoutJob.set(wait_until: @expert_reservation.payment_exec_time).perform_later(@expert_reservation)
  end
end
