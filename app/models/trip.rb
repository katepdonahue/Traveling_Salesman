class Trip < ActiveRecord::Base
  has_many :trip_waypoints
  has_many :waypoints, :through => :trip_waypoints
end