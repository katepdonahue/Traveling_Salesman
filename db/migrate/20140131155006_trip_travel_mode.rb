class TripTravelMode < ActiveRecord::Migration
  def change
    add_column :trips, :travel_mode, :string, :default => "TRANSIT"
  end
end
