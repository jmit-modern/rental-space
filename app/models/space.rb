class Space < ApplicationRecord
  attr_accessor :featured_image

  enum space_type: {
    room: 0,
    house: 1,
    warehouse: 2,
    plaza: 3,
  }, _prefix: true, _default: :room

  enum status: {
    inactive: 0,
    active: 1,
  }, _prefix: true, _default: :active

  belongs_to :country, class_name: "Country", foreign_key: "country_id", optional: true
  belongs_to :prefecture, class_name: "Prefecture", foreign_key: "prefecture_id", optional: true
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :category, class_name: "Category", foreign_key: "category_id"

  has_many :reservations, class_name: "Reservation", foreign_key: "space_id"
  has_many :space_images, class_name: "SpaceImage", foreign_key: "space_id", dependent: :destroy, inverse_of: :space
  accepts_nested_attributes_for :space_images, allow_destroy: true

  has_many :space_plans, class_name: "SpacePlan", foreign_key: "space_id"

  has_many :space_facilities
  has_many :facilities, through: :space_facilities

  validates :name, :space_type, :cancellation_deadline, :capacity, :address1, :price, :category_id, :lat, :lng, :status, presence: true

  default_scope { order("created_at DESC") }

  scope :filter_by_category, ->(category) { where("category_id = ?", category) }

  scope :with_limit, ->(limit) {
          limit(limit)
        }

  self.per_page = 9

  def featured_image
    self.space_images.first
  end
end
