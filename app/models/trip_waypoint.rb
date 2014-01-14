class TripWaypoint < ActiveRecord::Base
  attr_accessible :trip_id
  belongs_to :trip
  belongs_to :waypoint
end