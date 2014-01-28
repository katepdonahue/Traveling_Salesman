class Sub_Route < ActiveRecord::Base
  attr_accessible :origin_waypoint_id, :destination_waypoint_id, :departure_time, :google_results
  belongs_to :trip
  serialize :google_results, JSON
  
  def request_directions
    sleep(0.75)
    trip_origin = Waypoint.find(self.origin_waypoint_id).address.gsub(" ", "%20")
    trip_destination = Waypoint.find(self.destination_waypoint_id).address.gsub(" ", "%20")
    #check to see if the file already exist
    self.google_results = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{trip_origin}&destination=#{trip_destination}&sensor=false&departure_time=#{self.departure_time}&mode=driving")
  end

  def duration
    self.google_results["routes"][0]["legs"][0]["duration"]["text"]
  end

  def to_mins
    match = /((?<hours>\d*)\shours?)?\s?((?<mins>\d*)\smins?)?/.match(self.duration)
    hours = match[:hours] || 0
    mins = match[:mins] || 0
    hours.to_i * 60 + mins.to_i
  end



end