class StudentEnrollment
  include Mongoid::Document

  field :status, type: Integer, default: 0 # 0 - Undefined, 1 - Enrolling, 2 - Enrolled

  def enrolled?
    status == 2
  end

  def enrolling?
    status == 1
  end

  def enroll
    self.status = 2
  end

  belongs_to :student
  belongs_to :review_season
end
