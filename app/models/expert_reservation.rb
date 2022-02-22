class ExpertReservation < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :expert, class_name: "Expert"
  belongs_to :category, class_name: "Category"

  enum status: {
    waiting: 0,
    reserved: 1,
    cancelled: 2,
  }, _prefix: true

  default_scope { order("created_at DESC") }

  scope :filter_by_expert_user, ->(user_id) { where(expert: Expert.where(user: user_id)) }

  def payment_exec_time
    exec_time = self.created_at + self.expert.cancellation_deadline.hours
    if (exec_time > self.reserve_from)
      exec_time = self.reserve_from
    end
    return exec_time
  end
end
