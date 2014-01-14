class TripsController < ApplicationController

  def index
    @trip = Trip.new
    @start = Waypoint.create(:name => "Start", :latitude => 40.697327, :longitude => -73.986135)
    @end = Waypoint.create(:name =>"End", :latitude => 40.748444, :longitude => -73.985658)
    @hash = Gmaps4rails.build_markers(@trip) do |trip, marker|
      marker.lat @start.latitude
      marker.lng @start.longitude
    end
  end

end