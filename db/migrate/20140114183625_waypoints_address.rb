class WaypointsAddress < ActiveRecord::Migration
  def up
    add_column :waypoints, :address, :string
  end

  def down
    remove_column :waypoints, :address
  end
end
