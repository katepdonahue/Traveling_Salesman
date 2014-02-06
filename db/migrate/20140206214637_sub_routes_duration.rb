class SubRoutesDuration < ActiveRecord::Migration
  def up
    add_column :sub_routes, :duration, :string
    remove_column :sub_routes, :google_results
    remove_column :sub_routes, :departure_time
  end

  def down
    remove_column :sub_routes, :duration
    add_column :sub_routes, :google_results, :text
    add_column :sub_routes, :departure_time, :integer
  end
end
