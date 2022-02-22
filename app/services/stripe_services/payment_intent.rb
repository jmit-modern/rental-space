class StripeServices::PaymentIntent
  def self.create(customer_id, amount)
    payment_method = StripeServices::PaymentMethod.list(customer_id)

    intent = Stripe::PaymentIntent.create({
      amount: amount.to_s,
      currency: "jpy",
      customer: customer_id,
      payment_method: payment_method[:id],
      off_session: true,
      confirm: true,
    })
  end

  def self.capture(payment_intent_id)
    intent = Stripe::PaymentIntent.capture(payment_intent_id)
  end
end
