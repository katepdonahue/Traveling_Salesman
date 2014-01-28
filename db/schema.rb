# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140128170913) do

  create_table "routes", :force => true do |t|
    t.integer "departure_time"
    t.integer "total_time"
    t.boolean "best"
    t.integer "trip_id"
  end

  create_table "sub_routes", :force => true do |t|
    t.integer "origin_waypoint_id"
    t.integer "destination_waypoint_id"
    t.integer "departure_time"
    t.text    "google_results"
    t.integer "route_id"
  end

  create_table "trip_waypoints", :force => true do |t|
    t.integer "trip_id"
    t.integer "waypoint_id"
  end

  create_table "trips", :force => true do |t|
    t.string  "name"
    t.integer "departure_time", :default => 1390952041
  end

  create_table "waypoints", :force => true do |t|
    t.string "name"
    t.float  "latitude"
    t.float  "longitude"
    t.string "address"
  end

end
