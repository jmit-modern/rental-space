class ChangeLatLngTypeToFloat < ActiveRecord::Migration[6.1]
  change_table :spaces do |t|
    t.change :lat, :float
    t.change :lng, :float
  end
end
