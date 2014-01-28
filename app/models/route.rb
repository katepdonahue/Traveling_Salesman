class Route < ActiveRecord::Base
  attr_accessible :total_time, :best
  has_many :sub_routes
end