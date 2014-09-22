class TripsController < ApplicationController
  before_action :find_trip, except: [:index, :new, :create]

  def index
    @trips = Trip.all
  end
  
  def show
    @trip = Trip.find(params[:id])
    @item = Item.new
    @checklist = Checklist.new
  end
  
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_ids << current_user.id 
    @trip.admin = current_user.id

    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end  

  def edit; end
  
  def update
    if params[:add_friends]
      params[:trips][:user_ids].delete("")
      if params[:trips][:user_ids].present?
        params[:trips][:user_ids].each do |f|
          @trip.user_ids << BSON::ObjectId.from_string(f)
        end
        if @trip.update!
          @item = Item.new
          return redirect_to trip_path(@trip, @item)
        else
          render :show
        end
      else
        @item = Item.new
        return redirect_to trip_path(@trip, @item)
      end
    end
  
    if params[:delete_friend]
      @trip.user_ids.delete(BSON::ObjectId.from_string(params[:delete_friend]))
      
      if @trip.update!
        @item = Item.new
        return redirect_to trip_path(@trip, @item)
      else
        render :show
      end
    else
      @item = Item.new
      return redirect_to trip_path(@trip, @item)
    end
    
    
     
    if @trip.update_attributes(trip_params)
      redirect_to trip_path(@trip)
    else
      render :edit
    end
  end
  
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to user_path(current_user)
  end

  private
  
  def trip_params
    params.require(:trip).permit(:name, :description, :address)
  end

  def find_trip
    @trip = Trip.find(params[:id])
  end
end
