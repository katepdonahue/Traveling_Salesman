class TripWaypoint < ActiveRecord::Base
  has_many :trips
  has_many :waypoints
end