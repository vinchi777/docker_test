class StudentGrade
  include Mongoid::Document
  field :score, type: Integer

  belongs_to :grade
  belongs_to :student_enrollment

  validates_presence_of :score

  def student
    student_enrollment.student
  end
end