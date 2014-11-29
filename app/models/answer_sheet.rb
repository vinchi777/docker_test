class AnswerSheet
  include Mongoid::Document

  field :start_time, type: Time
  embeds_many :answers

  belongs_to :test
  validates_presence_of :test

  belongs_to :student
  validates_presence_of :student

  validate :one_instance

  def one_instance
    if AnswerSheet.where(test: test, student: student).exists?
      errors.add :test, 'exists already for student' + student.to_s
    end
  end
end

class Answer
  include Mongoid::Document

  field :question_index, type: Integer
  field :answer_index, type: Integer

  embedded_in :answer_key
end