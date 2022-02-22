class ExpertSerializer < ActiveModel::Serializer
  attributes :id, :user, :skill_title, :description, :price, :cancellation_deadline, :language_id, :language, :category_id, :category, :url

  belongs_to :user
  belongs_to :language
  belongs_to :category
  has_many :skills
end
