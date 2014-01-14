class Waypoint < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude
  has_many :trip_waypoints
  has_many :trips, :through => :trip_waypoints

  # acts_as_gmappable

  def gmaps4rails_address
    address
  end
  
end