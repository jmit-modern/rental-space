class SpaceFacility < ApplicationRecord
  belongs_to :space, class_name: "Space"
  belongs_to :facility, class_name: "Facility"
end
