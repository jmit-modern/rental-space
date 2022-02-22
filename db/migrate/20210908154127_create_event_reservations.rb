class CreateEventReservations < ActiveRecord::Migration[6.1]
  def up
    create_table :event_reservations do |t|
      t.belongs_to :event, index: true
      t.belongs_to :user, index: true
      t.string :qr_code, comment: "QR code image url"
      t.string :stripe_id, comment: "Stripe payment id"
      t.string :stripe_customer, comment: "Stripe customer id"
      t.string :stripe_payment_method, comment: "Stripe card id"
      t.integer :sub_total, comment: "Paid amount"
      t.integer :admin_fee, comment: "Admin fee"
      t.integer :owner_tax, comment: "Owner Tax"
      t.integer :paid_total, comment: "Paid amount"

      t.timestamps
    end
  end

  def down
    drop_table :event_reservations
  end
end
