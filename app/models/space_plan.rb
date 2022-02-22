class SpacePlan < ApplicationRecord
  belongs_to :space, class_name: "Space"
  has_many :reservations, class_name: "Reservation", foreign_key: "space_plan_id"
end
