class StudentEnrollment
  include Mongoid::Document
  include SimpleEnum::Mongoid

  as_enum :status, enrolling: 1, enrolled: 2

  scope :enrolled, -> do
    StudentEnrollment.where(status_cd: 2)
  end

  def enrolled?
    status == :enrolled
  end

  def enrolling?
    status == :enrolling
  end

  def enroll
    self.status = :enrolled
    student.is_enrolling = false
    student.save
    save
  end

  belongs_to :student
  belongs_to :review_season
  has_many :answer_sheets, dependent: :destroy
  has_many :student_grades, dependent: :destroy
end
