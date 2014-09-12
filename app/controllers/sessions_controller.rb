class SessionsController < ApplicationController
  
  def create   
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) 
      current_user
      login(user)
      redirect_to user_path(user)
    else
      render :root
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end      
  
  
  
end
