class AddCategoryToEvent < ActiveRecord::Migration[6.1]
  def change
    add_reference :events, :category, references: :category, index: true
  end
end
