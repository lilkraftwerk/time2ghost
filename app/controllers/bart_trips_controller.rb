class BartTripsController < ApplicationController
  include SessionHelper
  before_filter :require_login, [:show, :new, :create]


  def show
    @bart_trip = BartTrip.find(params[:id])
    @departure_station = Station.find_by_abbr(@bart_trip.departure_station).name
    @destination_station = Station.find_by_abbr(@bart_trip.destination_station).name
    render :show
  end

  def new
    @bart_trip = BartTrip.new
    @stations = Station.all
  end

  def create
    @bart_trip = BartTrip.new(params[:bart_trip])
    if @bart_trip.is_valid? && @bart_trip.save
      current_user.bart_trips << @bart_trip
      @bart_trip.update_departure_time
      redirect_to bart_trip_path(@bart_trip)
    else
      flash[:error] = "Trip creation error"
      redirect_to new_bart_trip_path
    end
  end

  def new_fake
    @bart_trip = BartTrip.new
  end

  def create_fake
    @bart_trip = BartTrip.new(params[:bart_trip])
    if @bart_trip.save
      current_user.bart_trips << @bart_trip
      @bart_trip.format_fake_trip(params[:time2go])
      redirect_to bart_trip_path(@bart_trip)
    else
      flash[:error] = "Trip creation error"
      render :new
    end
  end
   private

   def require_login
     unless logged_in?
       flash[:error] = "You must be logged in to access this section"
       redirect_to root_path # halts request cycle
     end
   end
end