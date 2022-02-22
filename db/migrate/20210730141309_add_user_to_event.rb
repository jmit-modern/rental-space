class AddUserToEvent < ActiveRecord::Migration[6.1]
  def change
    add_reference :events, :user, references: :user, index: true
  end
end
