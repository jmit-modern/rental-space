class Event < ApplicationRecord
  belongs_to :space, class_name: "Space", foreign_key: "space_id", optional: true
  belongs_to :language, class_name: "Language", foreign_key: "language_id", optional: true
  belongs_to :category, class_name: "Category", foreign_key: "category_id"
  belongs_to :user, class_name: "User", foreign_key: "user_id"

  default_scope { order("created_at DESC") }

  has_many :event_images, class_name: "EventImage", foreign_key: "event_id", dependent: :destroy, inverse_of: :event
  accepts_nested_attributes_for :event_images, allow_destroy: true

  has_many :event_reservations, class_name: "EventReservation", foreign_key: "event_id", inverse_of: :event

  enum price_type: {
    hourly: 0,
    fixed: 1,
  }, _prefix: true, _default: :hourly

  enum status: {
    inactive: 0,
    active: 1,
  }, _prefix: true, _default: :active

  validates :cancellation_deadline, :status, presence: true

  scope :filter_by_prefecture, ->(prefecture_id) { where(space: Space.where(prefecture: prefecture_id)) }

  self.per_page = 10
end
