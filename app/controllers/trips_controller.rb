class TripsController < ApplicationController

  def index
    @trip = Trip.new
    @start = Waypoint.create(:name => "Start", :latitude => 40.697327, :longitude => 73.986135)
    @end = Waypoint.create(:name =>"End", :latitude => 0, :longitude => 0)
  end

end