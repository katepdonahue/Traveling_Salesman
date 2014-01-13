class Waypoints < ActiveRecord::Migration
  def change
    create_table :waypoints do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamp
    end
  end
end
