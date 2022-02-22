class ChangeColumnsNullToEvents < ActiveRecord::Migration[6.1]
  def change
    change_column_null :events, :name, true
    change_column_null :events, :description, true
    change_column_null :events, :price, true
    change_column_null :events, :price_type, true
    change_column_null :events, :starting_at, true
    change_column_null :events, :ending_at, true
    change_column_null :events, :contact, true
  end
end
