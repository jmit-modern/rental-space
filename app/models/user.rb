class User < ApplicationRecord
  has_secure_password

  attr_accessor :full_name

  enum status: {
    inactive: 0,
    active: 1,
    deleted: 2,
  }, _prefix: true

  enum user_type: {
    user: 0,
    space_owner: 1,
    expert: 2,
    admin: 3,
    super_admin: 4,
  }, _prefix: true

  alias_attribute :plain_password, :password_digest

  has_many :spaces, class_name: "Space"
  has_many :events, class_name: "Event"
  has_one :expert, class_name: "Expert"
  accepts_nested_attributes_for :expert
  has_many :reservations, class_name: "Reservation"
  has_many :event_reservations, class_name: "EventReservation"

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true
  validates :plain_password, :presence => true
  validates_length_of :plain_password, :in => 8..32, :on => :create
  validates :user_type, :presence => true

  # passwords must never be modified, so doing this on create should be enough
  before_create :salt_and_hash_password!
  before_update :salt_and_hash_password!, :if => :plain_password_changed?

  def full_name
    [first_name, last_name].join(" ")
  end

  protected

  def salt_and_hash_password!
    self.password_digest = BCrypt::Password.create(plain_password)
  end

  def hash_matches?(plain)
    BCrypt::Password.new(hashed_password) == plain
  end
end
