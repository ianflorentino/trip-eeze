class TripsController < ApplicationController
  before_action :find_trip, except: [:index, :new, :create]

  def index
    @trips = Trip.all
  end
  
  def show
    @trip = Trip.find(params[:id])
    @item = Item.new
  end
  
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_ids << current_user.id 

    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end  

  def edit; end
  
  def update
    if @trip.update_attributes(trip_params)
      redirect_to trip_path(@trip)
    else
      render :edit
    end
  end
  
  private
  
  def trip_params
    params.require(:trip).permit(:name, :description)
  end

  def find_trip
    @trip = Trip.find(params[:id])
  end
end
