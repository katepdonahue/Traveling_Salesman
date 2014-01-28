class Routes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :total_time
      t.boolean :best
    end
  end
end