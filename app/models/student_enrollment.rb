class StudentEnrollment
  include Mongoid::Document
  include SimpleEnum::Mongoid

  as_enum :status, undefined: 0, enrolling: 1, enrolled: 2

  def enrolled?
    status == :enrolled
  end

  def enrolling?
    status == :enrolling
  end

  def enroll
    self.status = :enrolled
  end

  belongs_to :student
  belongs_to :review_season
end
