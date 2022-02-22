class StripeServices::CreateCharge
  def self.execute(token, amount, user_id, description = "")
    @customer = User.find(user_id)

    if @customer.stripe_customer.nil?
      stripe_customer = Stripe::Customer.create(
        email: @customer.email,
        source: token,
      )
      @customer.update(stripe_customer: stripe_customer.id)
    else
      stripe_customer = Stripe::Customer.update(
        @customer.stripe_customer, {
          source: token,
        }
      )
    end

    Stripe::Charge.create({
      customer: @customer.stripe_customer,
      amount: amount.to_s,
      currency: "jpy",
      description: description,
    })
  end
end
