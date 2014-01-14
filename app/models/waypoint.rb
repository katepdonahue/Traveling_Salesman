class Waypoint < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :address
  has_many :trip_waypoints
  has_many :trips, :through => :trip_waypoints

  geocoded_by :address
  after_validation :geocode
  acts_as_gmappable

  def gmaps4rails_address
    address
  end

end