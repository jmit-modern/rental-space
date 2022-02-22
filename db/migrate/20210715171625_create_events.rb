class CreateEvents < ActiveRecord::Migration[6.1]
  def up
    create_table :events do |t|
      t.string :name, comment: "Event name"
      t.text :description, comment: "Description"
      t.integer :price, comment: "Price"
      t.integer :price_type, comment: "Price type (0: hourly, 1: fixed)"
      t.belongs_to :space, index: true, comment: "Spaces.id"
      t.datetime :starting_at, comment: "Starting date time"
      t.datetime :ending_at, comment: "Starting date time"
      t.integer :cancellation_deadline, null: false, comment: "Cancellation deadline"
      t.belongs_to :language, comment: "Language"
      t.integer :status, comment: "Status (0: active, 1: deleted)"
      t.text :contact, comment: "Contact info"
      t.string :site_url, comment: "Site url"

      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
