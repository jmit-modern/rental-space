class AddLatLongToSpace < ActiveRecord::Migration[6.1]
  def change
    add_column :spaces, :lat, :decimal, { :precision => 10, :scale => 6 }
    add_column :spaces, :lng, :decimal, { :precision => 10, :scale => 6 }
  end
end
