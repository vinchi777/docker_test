class Test
  include Mongoid::Document
  field :description, type: String
  validates_presence_of :description

  field :date, type: Time
  validates_presence_of :date

  field :deadline, type: Time
  validates_presence_of :deadline

  field :timer, type: Integer
  validates_numericality_of :timer, greater_than_or_equal_to: 0, less_than_or_equal_to: 360, only_integer: true

  field :random, type: Boolean

  embeds_many :questions
  accepts_nested_attributes_for :questions
  validates_associated :questions

  def create_answer_sheet_for(student)
    AnswerSheet.create(student: student, test: self)
  end
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
  validate :has_answer

  def has_answer
    if answer.nil? || answer < 0 || answer > 3
      errors.add :answer, 'not found'
    end
  end

  field :ratio, type: String

  embedded_in :test
end
