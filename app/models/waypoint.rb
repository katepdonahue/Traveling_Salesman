class Waypoint < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude
  has_many :trip_waypoints
  has_many :trips, :through => :trip_waypoints
end