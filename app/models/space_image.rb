class SpaceImage < ApplicationRecord
  belongs_to :space, class_name: "Space"
end
