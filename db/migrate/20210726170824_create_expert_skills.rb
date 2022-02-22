class CreateExpertSkills < ActiveRecord::Migration[6.1]
  def up
    create_table :expert_skills do |t|
      t.belongs_to :expert, index: true, comment: "Experts.id"
      t.belongs_to :skill, index: true, comment: "Skills.id"
    end
  end

  def down
    drop_table :expert_skills
  end
end
