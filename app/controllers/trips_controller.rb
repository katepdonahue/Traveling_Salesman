class TripsController < ApplicationController

  # def index
  #   @trip = Trip.new
  # end

  def new
    @trip = Trip.new
    @trip.waypoints.build
  end

  def create
    @trip = Trip.new(params[:trip])
    @trip.save
    @trip.populate_routes
    @trip.save
    redirect_to "/trips/#{@trip.id}" #with ajax don't do this cuz will send get request to show right after
    # render :nothing => true 
  end

  def ajax
    debugger
    @trip = Trip.find(params.keys.first.to_i)
    @trip.add_duration(params)
  end


  def show
    @trip = Trip.find(params[:id])
    @data = {}
    @trip.routes.each do |route|
      @data[route.id] = {}
      route.sub_routes.each do |sub_route|
        origin = Waypoint.find(sub_route.origin_waypoint_id).address
        destination = Waypoint.find(sub_route.destination_waypoint_id).address
        @data[route.id][sub_route.id] = [origin, destination]
        # sub_route.format_sub_r_request.to_json
      end
    end
  end

end

