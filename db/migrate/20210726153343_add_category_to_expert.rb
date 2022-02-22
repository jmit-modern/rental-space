class AddCategoryToExpert < ActiveRecord::Migration[6.1]
  def change
    add_reference :experts, :category, references: :category, index: true
  end
end
