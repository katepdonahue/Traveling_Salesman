class RouteTotalTimeToArrivalTime < ActiveRecord::Migration
  def up
    remove_column :routes, :total_time
    add_column :routes, :arrival_time, :integer
  end

  def down
     add_column :routes, :total_time, :integer
     remove_column :routes, :arrival_time
  end
end
