class TripsController < ApplicationController

  def index
    @trip = Trip.new
  end

end