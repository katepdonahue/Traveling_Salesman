class Routes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :departure_time
      t.integer :total_time
      t.boolean :best
      t.integer :trip_id
    end
  end
end