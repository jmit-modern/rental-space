class StripeServices::Customer
  def self.create(token, email)
    customer = Stripe::Customer.create(
      email: email,
      source: token,
    )
  end

  def self.update(token, customer_id)
    customer = Stripe::Customer.update(
      customer_id, {
        source: token,
      }
    )
  end
end
