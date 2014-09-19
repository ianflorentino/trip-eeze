class Trip
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :address, type: String

  has_and_belongs_to_many :users
  has_many :items
  has_many :checklists

  validates_presence_of :name
end
