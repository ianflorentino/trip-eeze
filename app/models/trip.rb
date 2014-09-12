class Trip
  include Mongoid::Document
  field :name, type: String
  field :description, type: String

  has_and_belongs_to_many :users
  has_many :items
end
