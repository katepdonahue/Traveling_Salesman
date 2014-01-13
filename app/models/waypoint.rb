class Waypoint < ActiveRecord::Base
  has_many :trip_waypoints
  has_many :trips, :through => :trip_waypoints
end