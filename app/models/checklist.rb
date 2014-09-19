class Checklist
  include Mongoid::Document
  field :name, type: String
  field :budget, type: Integer
  field :checked, type: Mongoid::Boolean, default: false
  
  belongs_to :trip
  belongs_to :user
end
