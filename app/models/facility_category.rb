class FacilityCategory < ApplicationRecord
  has_many :facilities, class_name: "Facility", foreign_key: "facility_category_id"
end
