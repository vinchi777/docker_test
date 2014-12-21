class Question
  include Mongoid::Document

  field :text, type: String
  validates_presence_of :text

  field :choice1, type: String
  field :choice2, type: String
  field :choice3, type: String
  field :choice4, type: String

  field :answer, type: Integer
  validate :has_answer

  def has_answer
    if answer.nil? || answer < 0 || answer > 3
      errors.add :answer, 'not found'
    end
  end

  field :ratio, type: String

  has_and_belongs_to_many :test
end
