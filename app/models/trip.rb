class Trip < ActiveRecord::Base
	attr_accessible :name
  has_many :trip_waypoints
  has_many :waypoints, :through => :trip_waypoints
end