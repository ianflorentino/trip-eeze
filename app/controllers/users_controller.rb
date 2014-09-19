class UsersController < ApplicationController
  def index
    search_result = params[:query]
    @users = User.where(name: /.*#{search_result}.*/i).to_a  
  end
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end 
  
  def create
    @user = User.new(params.require(:user).permit(:name, :avatar, :email, :password))
    if @user.save
      login(@user)
      current_user 
      redirect_to user_path(@user)
    else
      render 'pages/front'
    end
  end
  
end
