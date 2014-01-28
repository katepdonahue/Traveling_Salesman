class TripDepartureTime < ActiveRecord::Migration
  def change
    add_column :trips, :departure_time, :integer
  end
end
