class StudentGrade
  include Mongoid::Document
  field :score, type: Integer
  field :to_delete, type: Boolean

  belongs_to :grade
  belongs_to :student_enrollment

  validates_presence_of :score, unless: :to_delete
  validates_presence_of :grade

  def student
    student_enrollment.student
  end

  def is_for_delete
    to_delete
  end

  def average
    (score*100.0/total_points).round
  end

  def total_points
    grade.points
  end

  def points
    score
  end

  def description
    grade.description
  end

  def date
    grade.date
  end

  def test?
    false
  end

  def timer?
    false
  end
end