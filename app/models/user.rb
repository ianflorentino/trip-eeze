require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Paperclip

  field :name, type: String
  field :email, type: String
  field :password_digest, type: String
  
  attr_accessor :default_style, :default_url 
 
  has_mongoid_attached_file :avatar, :styles => { :medium => "100x100>", :small => "60x60>", :thumb => "40x40>" }, :default_url => "http://i.imgur.com/UzrXKTs.gif", :default_style => :small
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_and_belongs_to_many :trips
  has_many :friendships, inverse_of: :owner
  has_many :items
  has_many :checklists
  
  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email

  ###### FOR AUTHENTICATION ######
  def password=(new_password)
    self.password_digest = BCrypt::Password.create(new_password)    
  end

  def authenticate(input_password)
    input_password && BCrypt::Password.new(self.password_digest) == input_password ? self : false
  end

  ###### FOR VIEWS ######
  def items_in_trip(trip)
    self.items.select{ |i| i.trip_id == trip.id }
  end
  
  def item_total(trip)
    self.items_in_trip(trip).map(&:price).reduce(&:+)
  end
 
  ###### FRIENDSHIP METHODS ###### 
  def friends
    self.friendships.select{ |f| f.pending == false }.map(&:friend)
  end

  def friend?(user)
    self.friends.include?(user)
  end
  
  def friends_not_on_trip(trip)
    self.friends.select{ |f| !f.trip_ids.include?(trip.id) }
  end

  def pending_friend_requests
    self.friendships.select{ |f| f.pending == true }.map(&:friend)
  end

  def friend_requests
    Friendship.where( pending: 'true', friend_id: self.id ).to_a.map(&:owner) 
  end
 
  def friend_requests_friendship(user)
    Friendship.where( pending: 'true', friend_id: self.id ).to_a.select{ |f| f.owner_id == user.id }.first.id 
  end
end
