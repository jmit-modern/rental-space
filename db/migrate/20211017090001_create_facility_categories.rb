class CreateFacilityCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :facility_categories do |t|
      t.string :name
      t.timestamps
    end
  end
end
