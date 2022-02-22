class Facility < ApplicationRecord
  belongs_to :facility_category, class_name: "FacilityCategory"
  has_many :space_facilities
  has_many :facilities, through: :space_facilities
end
