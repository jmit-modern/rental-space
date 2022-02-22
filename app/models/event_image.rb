class EventImage < ApplicationRecord
  belongs_to :event, class_name: "Event"
end
