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
    file = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{trip_origin}&destination=#{trip_destination}&TravelMode=TRANSIT&sensor=false&departure_time=#{Time.now.to_i}&mode=transit")
    #Time.to_i gives Unix time
    file["routes"][0]["legs"][0]["duration"]["text"]
  end

  def to_mins(i, j)
    duration = self.time(i,j)
    match = /(\d*)\shours?\s(\d*)\smins?/.match(duration)
    hour = match[1]
    mins = match[2]
    hour.to_i * 60 + mins.to_i
  end

  def ways
    mutable = []
    self.waypoints.each { |elt| mutable << elt }
    mutable.delete(self.start)
    mutable.delete(self.end)
    mutable.permutation.map(&:push)
  end

  def pairs(way)
    array = []
    (way.size - 1).times do |i|
      array << [way[i], way[i+1]]
    end
    array
  end

  def start?
    self.waypoints.each do |waypoint|
      return true if waypoint.name == "Start"
    end
  end

  def start
    if self.start?
      self.waypoints.each do |waypoint|
        return waypoint if waypoint.name == "Start"
      end
    end
  end


  def end?
    self.waypoints.each do |waypoint|
      return true if waypoint.name == "End"
    end
  end

  def end
    if self.end?
      self.waypoints.each do |waypoint|
        return waypoint if waypoint.name == "End"
      end
    end
  end



end