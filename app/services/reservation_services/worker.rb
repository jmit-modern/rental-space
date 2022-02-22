require "time"

class ReservationServices::Worker
  def self.time_diff(from, to)
    (Time.parse(to) - Time.parse(from)) / 3600
  end
end
