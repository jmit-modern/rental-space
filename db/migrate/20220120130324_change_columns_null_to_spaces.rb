class ChangeColumnsNullToSpaces < ActiveRecord::Migration[6.1]
  def change
    change_column_null :events, :user_id, true
    change_column_null :events, :category_id, true
    change_column_null :events, :price, true
    change_column_null :events, :status, true
    change_column_default :events, :status, Space.statuses[:active]
  end
end
