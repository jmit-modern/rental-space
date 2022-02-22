class StripeServices::PaymentMethod
  def self.list(customer_id)
    payment_method = Stripe::PaymentMethod.list({
      customer: customer_id,
      type: "card",
    })
  end
end
