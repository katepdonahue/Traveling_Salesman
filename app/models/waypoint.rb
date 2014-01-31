class Waypoint < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :address, :trip_waypoints_attributes
  geocoded_by :address
  after_validation :geocode
  has_many :trip_waypoints
  has_many :trips, :through => :trip_waypoints

end