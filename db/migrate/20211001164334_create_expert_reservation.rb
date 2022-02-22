class CreateExpertReservation < ActiveRecord::Migration[6.1]
  def up
    create_table :expert_reservations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :expert, index: true
      t.string :location, comment: "Reservation location"
      t.integer :people, comment: "Number of People"
      t.integer :children, comment: "Number of Children"
      t.belongs_to :category, index: true
      t.text :description, comment: "Usage description"
      t.integer :sub_total, comment: "Paid amount"
      t.integer :admin_fee, comment: "Admin fee"
      t.integer :owner_tax, comment: "Owner Tax"
      t.integer :total, comment: "Total paid"
      t.datetime :reserve_from, comment: "Reserve from"
      t.datetime :reserve_to, comment: "Reserve to"
      t.integer :approved, comment: "Approve status"
      t.integer :status, comment: "Reservation status"

      t.timestamps
    end
  end

  def down
    drop_table :expert_reservations
  end
end
