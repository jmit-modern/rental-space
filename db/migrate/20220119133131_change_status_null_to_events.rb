class ChangeStatusNullToEvents < ActiveRecord::Migration[6.1]
  def change
    change_column_null :events, :status, true
    change_column_default :events, :status, Event.statuses[:active]
  end
end
