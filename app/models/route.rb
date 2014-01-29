class Route < ActiveRecord::Base
  attr_accessible :arrival_time, :departure_time, :trip_id, :sub_routes, :sub_routes_attributes, :best
  has_many :sub_routes
  belongs_to :trip

  def route_request
    sub_route_departure_time = self.departure_time
    self.sub_routes.each do |sub_route|
      sleep(2)
      sub_route.request_directions(sub_route_departure_time)
      sub_route_departure_time += (sub_route.duration_in_mins * 60)
    end
    self.arrival_time = sub_route_departure_time
    self.save
  end

  def total_time
    total_mins = 0
    self.sub_routes.each do |sub_route|
      total_mins += sub_route.duration_in_mins
    end
    total_mins * 60
  end

  def strf_mins(mins)
    hours = 0
    until mins < 60
      hours += 1
      mins - 60
    end
    hours>1 ? h="#{hours} hours " : hours>0 ? h="#{hours} hour " : h=""
    mins>1 ? m="#{mins} mins " : mins>0 ? m="#{mins} min " : h=""
    h + m
  end

  def jon_strf_mins

  end

end