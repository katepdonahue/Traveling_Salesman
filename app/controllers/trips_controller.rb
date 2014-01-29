class TripsController < ApplicationController

  def index
    @trip = Trip.new
  end

  def new
    @trip = Trip.new
    @trip.waypoints.build
  end

  def create
    @trip = Trip.new(params[:trip])
    @trip.best_route
    @trip.save
    redirect_to "/trips/#{@trip.id}" #with ajax don't do this cuz will send get request to show right after
    # render :nothing => true 
  end

  def show
    @trip = Trip.find(params[:id])
    @hash = Gmaps4rails.build_markers(@trip.waypoints) do |waypoint, marker|
      marker.lat waypoint.latitude
      marker.lng waypoint.longitude
    end
  end

end

