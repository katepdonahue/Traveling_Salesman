class Legs < ActiveRecord::Migration
  def change
    create_table :legs do |t|
      t.string :distance
      t.string :duration
      :html_instructions
      :travel_mode
      :transit_details
    end
  end
end
