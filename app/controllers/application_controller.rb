class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user, :login, :exclude_current_user, :trip_total, :number_of_trip_attendees, :even_split, :checklist_total

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
  
  def trip_total(trip)
    trip.items.map(&:price).reduce(&:+)
  end
  
  def number_of_trip_attendees(trip)
    trip.users.count
  end
  
  def even_split(trip)
    trip_total(trip)/number_of_trip_attendees(trip)
  end
  
  def checklist_total(trip)
    trip.checklists.map(&:budget).reduce(&:+)
  end
end
