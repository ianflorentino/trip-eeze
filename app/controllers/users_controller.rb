class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end 
  
  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password))
    if @user.save
      login(@user)
      current_user 
      redirect_to user_path(@user)
    else
      render :new
    end
  end
  
end
