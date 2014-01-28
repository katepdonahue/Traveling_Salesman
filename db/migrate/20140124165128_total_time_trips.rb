class TotalTimeTrips < ActiveRecord::Migration
  def change
    add_column :trips, :total_time, :integer
  end
end
