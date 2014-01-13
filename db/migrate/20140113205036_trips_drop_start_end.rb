class TripsDropStartEnd < ActiveRecord::Migration
  def up
    remove_column :trips, :start
    remove_column :trips, :end
  end

  def down
    add_column :trips, :start, :float
    add_column :trips, :end, :float
  end
end
