class Expert < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :language, class_name: "Language", foreign_key: "language_id", optional: true
  belongs_to :category, class_name: "Category", foreign_key: "category_id", optional: true

  has_many :expert_skills
  has_many :skills, through: :expert_skills
  accepts_nested_attributes_for :skills, allow_destroy: true

  validates :cancellation_deadline, presence: true

  self.per_page = 10
end
