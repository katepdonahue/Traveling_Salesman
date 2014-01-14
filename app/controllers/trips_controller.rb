class TripsController < ApplicationController

  def index
    @trip = Trip.new
    # @trip.waypoints.build(:name => "Start", :latitude => 40.697327, :longitude => -73.986135)
    @trip.waypoints.build(:name =>"End", :latitude => 40.748444, :longitude => -73.985658)
    @trip.save
    @hash = Gmaps4rails.build_markers(@trip.waypoints) do |waypoint, marker|
      marker.lat waypoint.latitude
      marker.lng waypoint.longitude
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.waypoints.build(:name => params[:name], :latitude => params[:latitude].to_i, :longitude => params[:longitude].to_i)
    @trip.save
    @hash = Gmaps4rails.build_markers(@trip.waypoints) do |waypoint, marker|
      marker.lat waypoint.latitude
      marker.lng waypoint.longitude
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end

end

