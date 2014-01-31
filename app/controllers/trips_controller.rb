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
    @trip.save
    @trip.request
    redirect_to "/trips/#{@trip.id}" #with ajax don't do this cuz will send get request to show right after
    # render :nothing => true 
  end

  def show
    @trip = Trip.find(params[:id])
    @route = @trip.best_route
    @sub_route = @route.sub_routes.first
    respond_to do |format|
      format.html
      format.json {render json: @sub_route.google_results}
    end
  end


  def whatever
    @whatever = {:trips => 1}.to_json
    render :json => @whatever
  end

end

