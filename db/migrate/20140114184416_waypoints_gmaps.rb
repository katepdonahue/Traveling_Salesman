class WaypointsGmaps < ActiveRecord::Migration
  def up
    remove_column :waypoints, :gmap
    add_column :waypoints, :gmaps, :boolean
  end

  def down
    add_column :waypoints, :gmap, :boolean
    remove_column :waypoints, :gmaps
  end
end
