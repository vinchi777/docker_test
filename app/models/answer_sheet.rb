class AnswerSheet
  include Mongoid::Document

  field :start_time, type: Time
  field :submission_date, type: Time
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

  def started?
    !start_time.nil?
  end

  def start
    self.start_time = Time.now
  end

  def submitted?
    !submission_date.nil?
  end

  def submit
    self.submission_date = Time.now
  end

  def deadline?
    test.deadline?
  end

  def expired?
    remaining <= 0
  end

  def remaining
    start_time + test.timer * 60 - Time.now
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