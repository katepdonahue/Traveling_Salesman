class SubRoutes < ActiveRecord::Migration
  def change
    create_table :sub_routes do |t|
      t.string :origin_waypoint_id
      t.string :destination_waypoint_id
      t.integer :departure_time
      t.text :google_results
    end
  end
end
