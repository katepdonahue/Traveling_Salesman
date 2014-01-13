class TripWaypoint < ActiveRecord::Base
  attr_accessible :trip_id
  has_many :trips
  has_many :waypoints
end