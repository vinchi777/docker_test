class Test
  include Mongoid::Document
  field :description, type: String
  validates_presence_of :description

  field :date, type: Time
  validates_presence_of :date

  field :deadline, type: Time
  field :timer, type: Integer
  field :random, type: Boolean

  embeds_many :questions
  accepts_nested_attributes_for :questions
  validates_presence_of :questions
end

class Question
  include Mongoid::Document

  field :text, type: String
  validates_presence_of :text

  field :choice1, type: String
  field :choice2, type: String
  field :choice3, type: String
  field :choice4, type: String

  field :answer, type: Integer
  field :ratio, type: String

  embedded_in :test
end
