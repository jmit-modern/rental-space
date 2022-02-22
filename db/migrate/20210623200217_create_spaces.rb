class CreateSpaces < ActiveRecord::Migration[6.1]
  def up
    create_table :spaces do |t|
      t.belongs_to :user, index: true, comment: "Users.id"
      t.string :name, null: false, comment: "Space Name"
      t.text :description, comment: "Description"
      t.integer :space_type, null: false, comment: "Space Type (0: room, 1:House, 2: Warehouse, 3: plaza)"
      t.string :address1, comment: "Space Address 1"
      t.string :address2, comment: "Space Address 2"
      t.string :address3, comment: "Space Address 3"
      t.belongs_to :prefecture, index: true, comment: "prefectures.id"
      t.belongs_to :country, index: true, comment: "countries.id"
      t.string :zip_code, comment: "Zip code"
      t.string :url, comment: "URL"
      t.string :gps, comment: "GPS"
      t.float :price, comment: "Price"
      t.integer :cancellation_deadline, null: false, comment: "Cancellation deadline"
      t.integer :capacity, comment: "Capacity"
      t.string :language, comment: "Language"
      t.text :facility, comment: "Facility"
      t.text :lodging, comment: "Lodging"
      t.text :loud_volume, comment: "Loud volume"
      t.text :cooking, comment: "Cooking"
      t.text :wifi, comment: "Wifi"
      t.text :parking, comment: "Parking"
      t.integer :status, default: 0, comment: "Status (0: active, 1: deleted)"

      t.timestamps
    end
  end

  def down
    drop_table :spaces
  end
end
