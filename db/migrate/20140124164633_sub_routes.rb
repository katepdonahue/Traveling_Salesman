class SubRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :origin_waypoint
      t.string :destination_waypoint
      t.integer :departure_time
      t.string :json
    end
  end
end
