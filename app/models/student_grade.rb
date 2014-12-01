class StudentGrade
  include Mongoid::Document
  field :score, type: Integer

  belongs_to :grade
  belongs_to :student_enrollment
end