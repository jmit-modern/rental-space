class CreateCountries < ActiveRecord::Migration[6.1]
  def up
    create_table :countries do |t|
      t.string :name, null: false, comment: "Country Name"

      t.timestamps
    end
  end

  def down
    drop_table :countries
  end
end
