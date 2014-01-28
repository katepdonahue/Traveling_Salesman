class Sub_Routes < ActiveRecord::Base
  attr_accessible :origin_waypoint_id, :destination_waypoint_id, :departure_time, :json
  belongs_to :trip
end