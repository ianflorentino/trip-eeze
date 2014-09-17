class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user, :login, :exclude_current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end  

  def logged_in?
    !!current_user
  end

  def login(user)
    session[:user_id] = user.id
    current_user
  end
  
  def exclude_current_user(ary)
    ary.select{ |f| f.id != current_user.id }
  end  
 
  def exclude_already_added_to_trip(ary, trip)
    ary.select{ |f| f.trip_id != trip.id }
  end 
end
