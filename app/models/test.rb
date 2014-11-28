class Test
  include Mongoid::Document
  field :description, type: String
  field :date, type: Time
  field :deadline, type: Time
  field :timer, type: Integer
  field :random, type: Mongoid::Boolean
end
