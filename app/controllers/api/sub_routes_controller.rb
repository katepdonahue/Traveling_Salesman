module Api

  class SubRoutesController < ApplicationController
    respond_to :json

    def show
      respond_with SubRoute.find(params[:id]).google_results
    end

  end

end