class SubRoutes < ActiveRecord::Migration
  def change
    create_table :sub_routes do |t|
      t.integer :origin_waypoint_id
      t.integer :destination_waypoint_id
      t.integer :departure_time
      t.text :google_results
      t.integer :route_id
    end
  end
end
