class ChecklistsController < ApplicationController
  
  def create
    @checklist = Checklist.new(params.require(:checklist).permit(:name, :budget))
    @checklist.trip_id = params[:trip]

    if @checklist.save
      redirect_to trip_path(params[:trip], tab: 'checklist')
    else
      render 'trip/show'
    end
  end
  
  def update
    @trip = Trip.find(params[:trip_id])
    @checklist = Checklist.find(params[:id])
    @checklist.user_id = current_user.id
    @checklist.checked = true
  
    if @checklist.update!
      redirect_to trip_path(@trip, tab: 'checklist')
    else
      render 'trip/show'
    end
  end
  
end
