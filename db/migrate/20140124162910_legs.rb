class Legs < ActiveRecord::Migration
  def change
    create_table :legs do |t|
      t.string :distance
      t.string :duration
      t.string :html_instructions
      t.string :travel_mode
      t.string :arrival_time
      t.float :arrival_stop_lat
      t.float :arrival_stop_lng
      t.float :departure_time
      t.float :departure_stop_lat
      t.float :departure_stop_lng
      t.string :headsign
      t.string :color
      t.string :icon
      t.string :long_name
      t.string :short_name
    end
  end
end
