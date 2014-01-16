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
    @trip.waypoints.build
  end

  def create
    @trip = Trip.new(params[:trip])
    # params[:trip][:waypoints].each do |hash|
    #   @trip.waypoints.build(:name => hash[:name], :latitude => hash[:latitude], :longitude => hash[:longitude])
    # end
    @trip.save
    redirect_to "/trips/#{@trip.id}"
  end

  def show
    @trip = Trip.find(params[:id])
    @hash = Gmaps4rails.build_markers(@trip.waypoints) do |waypoint, marker|
      marker.lat waypoint.latitude
      marker.lng waypoint.longitude
    end
  end

end

