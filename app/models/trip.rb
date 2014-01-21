require "httparty"

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
    file = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{trip_origin}&destination=#{trip_destination}&TravelMode=TRANSIT&sensor=false&departure_time=1343641500&mode=transit")
    #Time.to_i gives Unix time
    debugger
    file["routes"][0]["legs"][0]["duration"]["text"]
  end

  def to_mins(duration)
    match = /(\d*)\shours?\s(\d*)\smins?/.match(duration)
    hour = match[1]
    mins = match[2]
    hour.to_i * 60 + mins.to_i
  end

  def arrayify
    array = []
    self.waypoints.each do |waypoint|
      array << waypoint.id
    end
    array
  end



end