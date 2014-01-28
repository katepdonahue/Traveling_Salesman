class TripDepartureTime < ActiveRecord::Migration
  def change
    add_column :trips, :departure_time, :integer, :default => Time.now.to_i
  end
end
