class TripWaypoints < ActiveRecord::Migration
  def change
    create_table :trip_waypoints do |t|
      t.integer :trip_id
      t.integer :waypoint_id

      t.timestamp
    end
  end
end
