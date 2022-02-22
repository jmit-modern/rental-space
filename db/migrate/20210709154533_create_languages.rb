class CreateLanguages < ActiveRecord::Migration[6.1]
  def up
    create_table :languages do |t|
      t.string :name, null: false, comment: "Language"

      t.timestamps
    end
  end

  def down
    drop_table :prefectures
  end
end
