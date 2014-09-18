class Item
  include Mongoid::Document
  field :name, type: String
  field :price, type: Float
  
  belongs_to :user
  belongs_to :trip  

  validates_presence_of :name, :price
end
