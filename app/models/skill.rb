class Skill < ApplicationRecord
  has_many :expert_skills
  has_many :experts, through: :expert_skills

  # validates :name, :uniqueness => true

  # scope :filter_by_user_id, ->(user_id) {
  #         where("category_id = ?", category)
  #       }

  def self.by_user(user_id)
    joins(expert_skills: :expert).where(expert: { user_id: user_id }).distinct
  end
end
