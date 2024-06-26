class CreateSkills < ActiveRecord::Migration[6.1]
  def up
    create_table :skills do |t|
      t.string :name, comment: "Skill name"

      t.timestamps
    end
  end

  def down
    drop_table :skills
  end
end
