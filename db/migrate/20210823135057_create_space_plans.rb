class CreateSpacePlans < ActiveRecord::Migration[6.1]
  def up
    create_table :space_plans do |t|
      t.belongs_to :space, index: true
      t.string :name, comment: "Plan name"
      t.integer :minimum_time, comment: "Minimum use time"
      t.integer :price, comment: "Plan price"

      t.timestamps
    end
  end

  def down
    drop_table :space_plans
  end
end
