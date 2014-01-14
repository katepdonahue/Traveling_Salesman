class WaypointsGmap < ActiveRecord::Migration
  def up
    add_column :waypoints, :gmap, :boolean
  end

  def down
    add_column :waypoints, :gmap
  end
end
