class AnswerSheet
  include Mongoid::Document

  field :started, type: Boolean
  field :start_time, type: Time
  embeds_many :answers

  field :submitted, type: Boolean

  belongs_to :test
  validates_presence_of :test

  belongs_to :student
  validates_presence_of :student

  validate :one_instance, on: :create

  def one_instance
    if AnswerSheet.where(test: test, student: student).exists?
      errors.add :test, 'exists already for student' + student.to_s
    end
  end
end

class Answer
  include Mongoid::Document

  field :index, type: Integer

  def question
    answer_sheet.test.questions.find(id)
  end

  embedded_in :answer_sheet
end