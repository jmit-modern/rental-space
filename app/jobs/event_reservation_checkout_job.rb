class EventReservationCheckoutJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(event_reservation)
    if (event_reservation.status_waiting?)
      @user = event_reservation.user
      begin
        StripeServices::PaymentIntent.create(@user.stripe_customer, event_reservation.total)
        event_reservation.status_reserved!
        # If payment is succeeded, update the payment status as reserved
      rescue Stripe::CardError => e
        # Error code will be authentication_required if authentication is needed
        puts "Error is: \#{e.error.code}"
        payment_intent_id = e.error.payment_intent.id
        payment_intent = Stripe::PaymentIntent.retrieve(payment_intent_id)
        puts payment_intent.id
        # If authentication Error send the email to the user to reauthenticate

        # If error Update the reservation reserve status to payment has error and make a instant payment link in the reservation pay

        #If Stripe card error, update the status of the reservation as Cancelled.
        event_reservation.status_cancelled!
      end
    else
      event_reservation.status_cancelled!
    end
  end
end
