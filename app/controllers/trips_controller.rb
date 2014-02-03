class TripsController < ApplicationController

  # def index
  #   @trip = Trip.new
  # end

  def new
    @trip = Trip.new
    @trip.waypoints.build
  end

  # def create
  #   @trip = Trip.new(params[:trip])
  #   @trip.save
  #   @trip.request
  #   redirect_to "/trips/#{@trip.id}" #with ajax don't do this cuz will send get request to show right after
  #   # render :nothing => true 
  # end

  def show
    @trip = Trip.find(params[:id])
    @route = @trip.best_route
    @sub_route = @route.sub_routes.first
    respond_to do |format|
      format.html
      format.json {render json: @sub_route.google_results}
    end
  end


  def calculate
    trip = Trip.new
    trip.populate_routes
    @hash = []
    trip.routes.each do |route|
      @hash[route.id] = []
      route.sub_routes.each do |sub_route|
        @hash[route.id][sub_route.id] = sub_route.format_sub_r_request
      end
    end
    render "/trips/#{@trip.id}"
  end

end

