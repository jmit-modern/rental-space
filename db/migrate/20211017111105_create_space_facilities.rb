class CreateSpaceFacilities < ActiveRecord::Migration[6.1]
  def change
    create_table :space_facilities do |t|
      t.references :space, null: false, index: true
      t.references :facility, null: false, index: true
      t.timestamps
    end
  end
end
