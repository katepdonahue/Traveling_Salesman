class TripsController < ApplicationController

  def index
    @trip = Trip.new
    @start = Waypoint.create(:name =>, :latitude =>, :longitude =>, :trip_id => @trip.id)
    @end = Waypoint.create(:name =>, :latitude =>, :longitude =>, :trip_id => @trip.id)
  end

end