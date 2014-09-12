class Friendship
  include Mongoid::Document
  field :pending, type: Mongoid::Boolean, default: true
  
  belongs_to :owner, class_name: "User"
  belongs_to :friend, class_name: "User"
end
