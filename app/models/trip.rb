class Trip < ActiveRecord::Base
	attr_accessible :name, :waypoints_attributes, :departure_time
  has_many :trip_waypoints, inverse_of: :waypoint
  has_many :waypoints, :through => :trip_waypoints
  has_many :routes
  has_many :sub_routes, :through => :routes

  accepts_nested_attributes_for :trip_waypoints
  accepts_nested_attributes_for :waypoints
  accepts_nested_attributes_for :routes


  def options
    mutable = []
    self.waypoints.each { |elt| mutable << elt }
    mutable.delete(self.start)
    mutable.delete(self.end)
    mutable.permutation.map(&:push)
  end

  def populate_sub_routes(way)
    new_route = Route.create(:departure_time=>self.departure_time, :trip_id=>self.id)
    way.unshift(self.start)
    way.push(self.end)
    (way.size - 1).times do |i|
      sub_route = {:origin_waypoint_id => way[i].id, :destination_waypoint_id => way[i+1].id}
      new_route.sub_routes.build(sub_route)
    end
    new_route.save
  end

  def populate_routes
    self.options.each do |option|
      self.populate_sub_routes(option)
    end
    self.save
  end

  def start
    self.waypoints.find_by_name("Start")
  end


  def end
    self.waypoints.find_by_name("End")
  end

  def request
    self.populate_routes
    self.routes.each { |route| route.route_request }
  end

  def best_route
    best_time = self.routes.first.total_time
    best = self.routes.first
    self.routes.each do |route| 
      if route.total_time < best_time
        best_time = route.total_time
        best = route
      end
    end
    best
  end

  def add_duration(hash)
    hash["#{self.id}"].each do |route_key, sub_route_hash|
      sub_route_hash.each do |sub_route_key, raw_duration|
        sub_route = SubRoute.find(sub_route_key.to_i)
        sub_route.duration = raw_duration
        sub_route.save
      end
    end
    self.save
  end


end