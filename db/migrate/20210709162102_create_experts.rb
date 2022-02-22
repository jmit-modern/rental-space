class CreateExperts < ActiveRecord::Migration[6.1]
  def up
    create_table :experts do |t|
      t.belongs_to :user, index:true, comment: "Users.id"
      t.string :skill_title, comment: "Skill title"
      t.text :description, comment: "Skill Description"
      t.integer :price, comment: "Price"
      t.integer :cancellation_deadline, null: false, comment: "Cancellation deadline"
      t.belongs_to :language, comment: "Languages.id"
      t.string :url, comment: "Url"
      t.timestamps
    end
  end

  def down
    drop_table :experts
  end
end
