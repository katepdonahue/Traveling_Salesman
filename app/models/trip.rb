class Trip < ActiveRecord::Base
	attr_accessible :name, :waypoints_attributes
  has_many :trip_waypoints
  has_many :waypoints, :through => :trip_waypoints
end