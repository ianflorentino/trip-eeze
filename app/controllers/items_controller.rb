class ItemsController < ApplicationController
  def new; end
  
  def create
    @item = Item.new(params.require(:item).permit(:name, :price))
    @item.user_id = current_user.id
    @item.trip_id = params[:trip]   
 
    if @item.save
      redirect_to trip_path(params[:trip])
    else
      render 'trips/show'   
    end
  end
end
