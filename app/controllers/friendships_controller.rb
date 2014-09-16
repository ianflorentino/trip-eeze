class FriendshipsController < ApplicationController
  def index
  end  
  
  def create
    @user = User.find(params[:format])
    @friendship = Friendship.new
    @friendship.owner = current_user.id
    @friendship.friend = @user.id
    
    if @friendship.save
      redirect_to users_path
    else
      render 'users/index'
    end
  end
  
  def update
    @friendship = Friendship.find(params[:id]) 
    @friendship.pending = false
    
    @user = User.find(@friendship.owner_id)
    @friendship2 = Friendship.new(pending: false, owner: current_user.id, friend: @user.id)
    
    if @friendship.update! && @friendship2.save
      redirect_to user_path(current_user)
    else
      render 'users/show'
    end
  end
  
end
