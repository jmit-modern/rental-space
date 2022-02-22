class Prefecture < ApplicationRecord
  has_one :space, class_name: "Space"
end
