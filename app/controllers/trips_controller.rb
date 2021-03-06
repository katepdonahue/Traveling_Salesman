class TripsController < ApplicationController

  # def index
  #   @trip = Trip.new
  # end

  def new
    @trip = Trip.new
    @trip.waypoints.build
  end

  def create
    trip = Trip.new(params[:trip])
    trip.save
    trip.populate_routes
    trip.save
    @data = {}
    @data[trip.id] = {}
    trip.routes.each do |route|
      @data[trip.id][route.id] = {}
      route.sub_routes.each do |sub_route|
        origin_address = Waypoint.find(sub_route.origin_waypoint_id).address
        destination_address = Waypoint.find(sub_route.destination_waypoint_id).address
        @data[trip.id][route.id][sub_route.id] = {"origin" => origin_address, 
                                         "destination" => destination_address,
                                         "transitOptions" => {:departureTime => Date.today},
                                         "travelMode" => ""}
      end
    end
    render :json => @data 
  end

  def ajax
    @trip = Trip.find(params.keys.first.to_i)
    @trip.add_duration(params)
    @best_route_key = @trip.best_route
    respond_to do |format|
      format.json{
        render :json => @best_route_key.id.to_json
      }
    end
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
      end
    end
  end

end

