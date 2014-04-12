class TripsController < ApplicationController
  def show
    @trip = Trip.find(params[:id])
    render :show
  end

  def new
    @trip = Trip.new
  end

  def create
    current_location = params[:trip].delete(:current_location)
    @trip = Trip.new(params[:trip])
    @trip.calculate_bart_gmap(current_location)
    # @trip.calculate_gmaps_and_bart(current_location, )

    if @trip.save
      redirect_to @trip
    else
      flash[:error] = "Trip creation error"
      render :new
    end
  end
end