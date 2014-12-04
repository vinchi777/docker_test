class AnswerSheet
  include Mongoid::Document

  field :start_time, type: Time
  field :submission_date, type: Time
  embeds_many :answers

  belongs_to :test
  validates_presence_of :test

  belongs_to :student_enrollment
  validates_presence_of :student_enrollment

  validate :one_instance, on: :create

  def one_instance
    if AnswerSheet.where(test: test, student_enrollment: student_enrollment).exists?
      errors.add :test, 'exists already for student ' + student_enrollment.student.to_s
    end
  end

  def student
    student_enrollment.student
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
    start_time + test.timer * 60 - Time.now if start_time && test.timer != 0
  end

  def correct_points
    answers.select { |a| a.correct? }.length if deadline?
  end

  def total_points
    test.questions.length
  end

  def percent
    (correct_points / total_points.to_d * 100) if deadline?
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