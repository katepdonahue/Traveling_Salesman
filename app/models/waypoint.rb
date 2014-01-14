class Waypoint < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :address
  has_many :trip_waypoints
  has_many :trips, :through => :trip_waypoints

  include Gmaps4rails::ActsAsGmappable
  geocoded_by :address
  after_validation :geocode
  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_address
    address
  end

end