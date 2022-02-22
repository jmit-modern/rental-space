class Language < ApplicationRecord
    has_many :experts, class_name: "Expert", foreign_key: "expert_id"
    has_many :events, class_name: "Event", foreign_key: "event_id"
end
