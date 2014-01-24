class SubRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :arrival_time
      t.string :departure_time
      t.integer :duration
      t.string :distance
      t.string :overview_polyline
      t.string :warning
    end
  end
end
