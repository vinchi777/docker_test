class AnswerSheet
  include Mongoid::Document

  field :start_time, type: Time
  field :submission_date, type: Time
  embeds_many :answers

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
    if remaining
      remaining <= 0
    else
      false
    end
  end

  def remaining
    start_time + test.timer * 60 - Time.now if start_time
  end

  def correct_points
    answers.count { |a| a.correct? } if deadline?
  end

  def total_points
    test.questions.length
  end

  def percent
    '%.1f' % (correct_points / total_points.to_d * 100) if deadline?
  end
end

class Answer
  include Mongoid::Document

  field :index, type: Integer

  def question
    answer_sheet.test.questions.find(id)
  end

  def correct?
    index == question.answer
  end

  embedded_in :answer_sheet
end