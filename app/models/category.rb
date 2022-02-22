class Category < ApplicationRecord
  has_many :spaces, class_name: "Space", foreign_key: "category_id"
  has_many :experts, class_name: "Expert", foreign_key: "category_id"
  has_many :events, class_name: "Event", foreign_key: "category_id"
  has_many :reservations, class_name: "Event", foreign_key: "category_id"
end
