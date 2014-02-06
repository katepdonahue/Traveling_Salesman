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
    trip.populate_routes
    @trip.save
    redirect_to "/trips/#{@trip.id}" #with ajax don't do this cuz will send get request to show right after
    # render :nothing => true 
  end

  # def show
  #   @trip = Trip.find(params[:id])
  #   @route = @trip.best_route
  #   @sub_route = @route.sub_routes.first
  #   respond_to do |format|
  #     format.html
  #     format.json {render json: @sub_route.google_results}
  #   end
  # end


  def show
    trip = Trip.find(params[:id])
    @data = {}
    trip.routes.each do |route|
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

