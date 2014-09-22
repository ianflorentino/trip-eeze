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
    if params[:add_checklist] == 'true'
      @checklist = Checklist.find(params[:id])
      @checklist.user_id = current_user.id 
     
      if @checklist.update! 
        respond_to do |format|
          format.js { render 'trips/update' }
        end
      end
    elsif params[:add_checklist] == 'false'
      @checklist = Checklist.find(params[:id])
      @checklist.user_id = nil 
      
      if @checklist.update!
        respond_to do |format|
          format.js { render 'trips/update' }
        end
      end
    else
      @checklist = Checklist.find(params[:id])
      if @checklist.update!
        redirect_to trip_path(params[:tripId], tab: 'checklist')
      else
        render 'trip/show'
      end
     end
  end
end
