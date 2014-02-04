class SubRoute < ActiveRecord::Base
  attr_accessible :origin_waypoint_id, :destination_waypoint_id, :departure_time, :google_results
  serialize :google_results, JSON
  belongs_to :route
  
  def request_directions(sub_route_departure_time)
    self.departure_time = sub_route_departure_time
    origin = Waypoint.find(self.origin_waypoint_id).address.gsub(" ", "%20")
    destination = Waypoint.find(self.destination_waypoint_id).address.gsub(" ", "%20")
    #check to see if the file already exist
    self.google_results = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&sensor=false&departure_time=#{self.departure_time}&mode=transit")
    self.save
  end

  def duration
    self.google_results["routes"][0]["legs"][0]["duration"]["text"]
  end

  def duration_in_mins
    match = /((?<hours>\d*)\shours?)?\s?((?<mins>\d*)\smins?)?/.match(self.duration)
    hours = match[:hours] || 0
    mins = match[:mins] || 0
    hours.to_i * 60 + mins.to_i
  end

  def format_sub_r_request
    start = Waypoint.find(self.origin_waypoint_id).address
    ending = Waypoint.find(self.destination_waypoint_id).address
    { origin: start,
      destination: ending,
      travelMode: "google.maps.TravelMode.TRANSIT",
      departureTime: Time.now.to_i } # needs to be a date object, why????
    # save all formatted subroutes in json file at http://localhost:3000/api/trip/:id.json
  end



end