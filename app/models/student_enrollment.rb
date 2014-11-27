class StudentEnrollment
  include Mongoid::Document
  include SimpleEnum::Mongoid

  as_enum :status, enrolling: 1, enrolled: 2

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

  def self.status_json
    StudentEnrollment.statuses.map do |e|
      {key: e[0].titleize, value: e[1]}
    end
  end
end
