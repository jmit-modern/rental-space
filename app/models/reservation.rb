class Reservation < ApplicationRecord
  attr_accessor :plan_id, :payment_exec_time
  alias_attribute :plan_id, :space_plan_id

  belongs_to :space, class_name: "Space"
  belongs_to :space_plan, class_name: "SpacePlan"
  belongs_to :user, class_name: "User"
  belongs_to :category, class_name: "Category"

  enum status: {
    waiting: 0,
    reserved: 1,
    cancelled: 2,
  }, _prefix: true

  default_scope { order("created_at DESC") }

  scope :filter_by_space_owner, ->(owner_id) { where(space: Space.where(user_id: owner_id)) }

  def payment_exec_time
    exec_time = self.created_at + self.space.cancellation_deadline.hours
    if (exec_time > self.reserve_from)
      exec_time = self.reserve_from
    end
    return exec_time
  end
end
