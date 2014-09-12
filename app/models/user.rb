require 'bcrypt'

class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :password_digest, type: String

  has_and_belongs_to_many :trips
  has_many :friendships, inverse_of: :owner
  has_many :items
  
  ## FOR AUTHENTICATION
  def password=(new_password)
    self.password_digest = BCrypt::Password.create(new_password)    
  end

  def authenticate(input_password)
    input_password && BCrypt::Password.new(self.password_digest) == input_password ? self : false
  end

  ##FOR VIEWS
  def items_in_trip(trip)
    self.items.select{ |i| i.trip_id == trip.id }
  end
  
  def friends
    self.friendships.map(&:friend)
  end
end
