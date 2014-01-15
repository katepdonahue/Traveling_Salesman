class TripWaypoint < ActiveRecord::Base
  attr_accessible :trip_id
  belongs_to :trip
  belongs_to :waypoint

  validate_presence_of :trip
  validate_presence_of :waypoint

  accepts_nested_attributes_for :waypoint
end