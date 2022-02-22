class StripeServices::SetupIntent
  def self.create(token, user_id)
    @customer = User.find(user_id)

    if @customer.stripe_customer.nil?
      stripe_customer = StripeServices::Customer.create(token, @customer.email)
      @customer.update(stripe_customer: stripe_customer.id)
    else
      stripe_customer = StripeServices::Customer.update(token, @customer.stripe_customer)
    end

    intent = Stripe::SetupIntent.create({
      customer: @customer.stripe_customer,
      payment_method_types: ["card"],
    })
  end
end
