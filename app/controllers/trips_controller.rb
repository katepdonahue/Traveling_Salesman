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

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.find_by_name(params[:trip][:name])
    @trip.waypoints.build(:name => params[:trip][:name], :latitude => params[:trip][:waypoints][:latitude].to_i, :longitude => params[:trip][:waypoints][:longitude].to_i)
    @trip.save

    redirect_to @trip
  end

  def show
    @trip = Trip.find(params[:id])
    @hash = Gmaps4rails.build_markers(@trip.waypoints) do |waypoint, marker|
      marker.lat waypoint.latitude
      marker.lng waypoint.longitude
    end
  end

end

