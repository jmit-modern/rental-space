class CreatePrefectures < ActiveRecord::Migration[6.1]
  def up
    create_table :prefectures do |t|
      t.string :name, null: false, comment: "Prefecture Name"

      t.timestamps
    end
  end

  def down
    drop_table :prefectures
  end
end
