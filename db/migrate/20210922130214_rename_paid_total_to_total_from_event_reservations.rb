class RenamePaidTotalToTotalFromEventReservations < ActiveRecord::Migration[6.1]
  def change
    rename_column :event_reservations, :paid_total, :total
  end
end
