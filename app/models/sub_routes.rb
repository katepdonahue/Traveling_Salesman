class Sub_Routes < ActiveRecord::Base
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


end