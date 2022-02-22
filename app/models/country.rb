class Country < ApplicationRecord
  has_one :space, class_name: "Space"
end
