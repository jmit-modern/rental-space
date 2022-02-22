class EventReservation < ApplicationRecord
  attr_accessor :payment_exec_time
  belongs_to :event, class_name: "Event"
  belongs_to :user, class_name: "User"

  enum status: {
    waiting: 0,
    reserved: 1,
    cancelled: 2,
  }, _prefix: true

  scope :filter_by_event_owner, ->(owner_id) { where(event: Event.where(user_id: owner_id)) }

  def payment_exec_time
    exec_time = self.created_at + self.event.cancellation_deadline.hours
    if (exec_time > self.event.starting_at)
      exec_time = self.event.starting_at
    end
    return exec_time
  end
end
