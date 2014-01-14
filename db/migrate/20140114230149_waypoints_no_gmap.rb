class WaypointsNoGmap < ActiveRecord::Migration
  def up
    remove_column :waypoints, :gmaps
  end

  def down
    add_column :waypoints, :gmaps, :boolean
  end
end
