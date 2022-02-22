class CreateFacilities < ActiveRecord::Migration[6.1]
  def change
    create_table :facilities do |t|
      t.string :name
      t.belongs_to :facility_category, index: true
      t.timestamps
    end
  end
end
