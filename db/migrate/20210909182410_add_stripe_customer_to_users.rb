class AddStripeCustomerToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :stripe_customer, :string
  end
end
