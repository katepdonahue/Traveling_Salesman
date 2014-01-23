class Trip < ActiveRecord::Base
	attr_accessible :name, :waypoints_attributes
  has_many :trip_waypoints, inverse_of: :waypoint
  has_many :waypoints, :through => :trip_waypoints

  accepts_nested_attributes_for :trip_waypoints
  accepts_nested_attributes_for :waypoints

  def time(pair)
    trip_origin = pair[0].address.gsub(" ", "%20")
    trip_destination = pair[1].address.gsub(" ", "%20")
    file = HTTParty.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{trip_origin}&destination=#{trip_destination}&sensor=false&departure_time=#{Time.now.to_i}&mode=driving")
    #Time.to_i gives Unix time
    file["routes"][0]["legs"][0]["duration"]["text"]
  end

  def to_mins(pair)
    duration = self.time(pair)
    match = /((?<hours>\d*)\shours?)?\s?((?<mins>\d*)\smins?)?/.match(duration)
    hours = match[:hours] || 0
    mins = match[:mins] || 0
    hours.to_i * 60 + mins.to_i
  end

  def options
    mutable = []
    self.waypoints.each { |elt| mutable << elt }
    mutable.delete(self.start)
    mutable.delete(self.end)
    mutable.permutation.map(&:push)
  end

  def pairs(way)
    way.unshift(self.start)
    way.push(self.end)
    array = []
    (way.size - 1).times do |i|
      array << [way[i], way[i+1]]
    end
    array
  end

  def ways
    ways = Array.new
    self.options.each do |option|
      ways << self.pairs(option)
    end
    ways
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

  def total_time(way)
    total_time = 0
    way.each do |pair|
      total_time += self.to_mins(pair)
    end
    total_time
  end

  def best_route
    best_way = self.ways.first
    best = self.total_time(best_way)
    self.ways.each do |way|
      if self.total_time(way) < best
        best = self.total_time(way)
        best_way = way
      end
    end
    best_way
  end


end