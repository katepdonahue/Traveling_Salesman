class Trips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.float :start
      t.float :end
      
      t.timestamp
    end
  end
end
