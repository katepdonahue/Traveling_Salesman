require "open-uri"

class Trip < ActiveRecord::Base
	attr_accessible :name, :waypoints_attributes
  has_many :trip_waypoints, inverse_of: :waypoint
  has_many :waypoints, :through => :trip_waypoints

  accepts_nested_attributes_for :trip_waypoints
  accepts_nested_attributes_for :waypoints

  def route

  end

  def time(i, j)
    trip_origin = self.waypoints[i].address.gsub(" ", "%20")
    trip_destination = self.waypoints[j].address.gsub(" ", "%20")
    file = open("https://maps.googleapis.com/maps/api/directions/json?origin=#{trip_origin}&destination=#{trip_destination}&sensor=false")
    duration = file["routes"]["legs"]["duration"]["text"]
  end

end