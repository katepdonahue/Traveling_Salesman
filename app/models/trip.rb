class Trip < ActiveRecord::Base
	attr_accessible :name, :waypoints_attributes, :departure_time
  has_many :trip_waypoints, inverse_of: :waypoint
  has_many :waypoints, :through => :trip_waypoints
  has_many :routes
  has_many :sub_routes, :through => :routes

  accepts_nested_attributes_for :trip_waypoints
  accepts_nested_attributes_for :waypoints


  def options
    mutable = []
    self.waypoints.each { |elt| mutable << elt }
    mutable.delete(self.start)
    mutable.delete(self.end)
    mutable.permutation.map(&:push)
  end

  def pairs(way)
    new_route = Route.new
    way.unshift(self.start)
    way.push(self.end)
    (way.size - 1).times do |i|
      sub_route = Sub_Route.new.create(:origin_waypoint_id => way[i].id, :destination_waypoint_id => way[i+1].id)
      new_route.sub_routes.build(sub_route)
    end
    self.routes.build(new_route)
    self.save
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
    start_time = Time.now.to_i
    way.each do |pair|
      total_time += self.to_mins(pair, start_time)
      start_time += total_time * 60 # that converts total_time to unix
    end
    total_time
  end

  def best_route
    return self.ways.first if self.ways.count == 1
    best_way = self.routes.first
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