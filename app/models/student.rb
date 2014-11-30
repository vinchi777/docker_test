class Student < Person
  include Util

  DAYS_TILL_EXPIRATION = 3

  validates_presence_of :sex, if: :can_validate_info?
  validates_presence_of :address, if: :can_validate_info?
  validates_presence_of :contactNo, if: :can_validate_info?
  validates_presence_of :email, if: :can_validate_info?

  field :parentFirstName, type: String
  field :parentLastName, type: String
  field :parentContact, type: String

  field :lastAttended, type: String
  validates_presence_of :lastAttended, if: :can_validate_education?

  field :yearGrad, type: Integer
  validates_presence_of :yearGrad, if: :can_validate_education?
  validates_numericality_of :yearGrad, greater_than: :hsYear, message: 'must be later than High School Year', if: :can_validate_education?

  field :recognition, type: String
  field :hs, type: String
  validates_presence_of :hs, if: :can_validate_education?

  field :hsYear, type: Integer
  validates_presence_of :hsYear, if: :can_validate_education?
  validates_numericality_of :hsYear, greater_than: :elemYear, message: 'must be later than Elementary Year', if: :can_validate_education?

  field :elem, type: String
  validates_presence_of :elem, if: :can_validate_education?

  field :elemYear, type: Integer
  validates :elemYear, presence: true, if: :can_validate_education?

  field :referrerFirstName, type: String
  field :referrerLastName, type: String
  field :referrerContact, type: String

  field :why, type: String
  field :facebook, type: String
  field :twitter, type: String
  field :linkedin, type: String
  field :enrollment_process, type: Integer, default: 0
  field :agreed, type: Boolean
  field :finish_enrollment_on, type: DateTime
  field :package_type, type: String
  field :profile_pic, type: String

  # Caching purposes
  field :is_enrolling, type: Boolean, default: false

  has_many :invoices, class_name: 'StudentInvoice'
  has_many :enrollments, class_name: 'StudentEnrollment'
  has_many :answer_sheets
  has_many :student_grades, dependent: :destroy

  scope :filter, ->(season, status) do
    if season.nil? || season == '0' # No season filter
      if status.nil? || status == '-1'
        Student.all
      else
        ids = StudentEnrollment.where(status_cd: status.to_i).map { |e| e.student.id }
        Student.in(id: ids)
      end
    else # With season filter
      s = ReviewSeason.find(season)
      if s && status.nil? || status == '-1'
        Student.in(id: s.enrollments.map { |e| e.student.id })
      elsif s
        ids = s.enrollments.select { |e| e.status_cd == status.to_i }.map { |e| e.student.id }
        Student.in(id: ids)
      else
        Student.all
      end
    end
  end

  def setup_payment
    current_season = ReviewSeason.current
    invoice1 = StudentInvoice.create(
        package: package_type,
        review_season: current_season,
        amount: current_season.get_fee(package_type)
    )
    add_invoice(invoice1)

    if package_type == 'Double'
      invoice1.description = 'Invoice 1 of 2'
      amount = current_season.double_review - current_season.full_review
      invoice2 = StudentInvoice.create(
          package: package_type,
          description: 'Invoice 2 of 2',
          review_season: current_season,
          amount: amount
      )
      add_invoice(invoice2)
    end
    save
  end

  def balance
    invoices.map { |i| i.balance }.sum
  end

  def has_balance?
    balance > 0
  end

  def enrolling?
    if current_enrollment
      current_enrollment.enrolling?
    else
      false
    end
  end

  def has_enrollment_on(season)
    enrollments.any? { |x| x.review_season = season }
  end

  def enrollment_status
    if current_enrollment
      current_enrollment.status
    else
      :undefined
    end
  end

  def current_enrollment
    enrollments.sort_by { |i| i.review_season.season_start }.last
  end

  def enrolled?
    if current_enrollment
      current_enrollment.enrolled?
    else
      false
    end
  end

  def current_season
    if current_invoice
      current_invoice.review_season.season
    else
      ''
    end
  end

  def current_invoice
    invoices.sort_by { |i| i.review_season.season_start }.last
  end

  def current_invoices
    invoices.where(review_season: current_invoice.review_season) if invoices
  end

  def total_current_amount
    current_invoices.reduce(0) { |sum, i| sum+i.amount }
  end

  def finish_enrollment_process
    self.finish_enrollment_on = DateTime.now
    self.save
  end

  def expired?
    (finish_enrollment_on && DateTime.now > finish_enrollment_on + DAYS_TILL_EXPIRATION.days) || (!finish_enrollment_on && enrollment_status.present?)
  end

  def as_json(opt = nil)
    hash = self.serializable_hash(nil)
    hash[:middle_initial] = middle_initial
    hash[:id] = id.to_s
    hash[:enrollment_status] = enrollment_status
    hash[:current_season] = current_season
    hash[:user_id] = user.id.to_s if user.present?
    hash[:user_id] = nil if user.nil?
    hash[:balance] = balance unless balance.nil?
    hash.as_json(nil)
  end

  def has_profile_pic?
    profile_pic.present?
  end

  def save_profile_pic(img, clean)
    unless clean == 'true'
      self.profile_pic = save_file(img, id.to_s, profile_pic, 'students')
    end
  end

  def add_invoice(invoice)
    invoice.student = self
    invoice.save
    unless has_enrollment_on invoice.review_season
      enrollment = StudentEnrollment.new(status: 1, student: self)
      enrollment.review_season = invoice.review_season
      enrollment.save
      self.is_enrolling = true
    end
  end

  def trailing_name
    ", #{firstName} #{middleName}"
  end

  private
  def can_validate_info?
    enrollment_process == 0 || enrollment_process == 1
  end

  def can_validate_education?
    enrollment_process == 0 ||enrollment_process == 2
  end

  def can_validate_others?
    enrollment_process == 0 || enrollment_process == 3
  end
end
