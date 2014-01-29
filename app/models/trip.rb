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

  def request
    self.populate_routes
    self.routes.each { |route| route.route_request }
  end

  def best_route
    self.request
    # best_route = self.routes.first
    # best_time = self.routes.first.total_time
    best_route = Route.where(:trip_id=>self.id).minimum(:total_time)
    # self.routes.each do |route| # is there a way to get the smallest time directly from the total_time column?
    #   if route.duration < best_time
    #     best_time = route.total_time
    #     best_route = route
    #   end
    # end
    best_route
    # best_route.best = true
    # self.routes.each { |route| route.delete if best_route.best != true }
  end


end