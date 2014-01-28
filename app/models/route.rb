class Route < ActiveRecord::Base
  attr_accessible :total_time, :departure_time, :trip_id, :sub_routes, :sub_routes_attributes, :best
  has_many :sub_routes
  belongs_to :trip
end