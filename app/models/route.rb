class Route < ActiveRecord::Base
  attr_accessible :total_time, :departure_time, :trip_id, :sub_routes, :sub_routes_attributes, :best
  has_many :sub_routes
  belongs_to :trip

  def duration
    total = 0
    start_time = self.departure_time
    self.sub_routes.each do |sub_route|
      total += sub_route.to_mins
      start_time += total * 60
    end
    total
  end

  def request
    self.sub_routes.each { |sub_route| sub_route.request_directions }
  end

end