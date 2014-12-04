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
end