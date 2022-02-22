class ReservationCheckoutJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(reservation)
    if (reservation.approved == 1 && reservation.status_waiting?)
      @user = reservation.user
      begin
        StripeServices::PaymentIntent.create(@user.stripe_customer, reservation.total)
        reservation.status_reserved!
        # If payment is succeeded, update the payment status as reserved
        ## Action Update payment status
        ReservationMailer.with(:reservation => reservation).expert_email_payment_complete.deliver_later
        ReservationMailer.with(:reservation => reservation).user_email_payment_complete.deliver_later
      rescue Stripe::CardError => e
        # Error code will be authentication_required if authentication is needed
        puts "Error is: \#{e.error.code}"
        payment_intent_id = e.error.payment_intent.id
        payment_intent = Stripe::PaymentIntent.retrieve(payment_intent_id)
        puts payment_intent.id
        # If authentication Error send the email to the user to reauthenticate

        # If error Update the reservation reserve status to payment has error and make a instant payment link in the reservation pay

        #If Stripe card error, update the status of the reservation as Cancelled.
        reservation.status_cancelled!
      end
    else
      reservation.status_cancelled!
      ReservationMailer.with(:reservation => reservation).user_email_reservation_canceled.deliver_later
    end
  end
end
