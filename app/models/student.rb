class Student
  include Mongoid::Document

  field :firstName, type: String
  validates_presence_of :firstName, if: :can_validate_info?

  field :middleName, type: String

  field :lastName, type: String
  validates_presence_of :lastName, if: :can_validate_info?

  field :birthdate, type: Date, default: Date.today
  validates_presence_of :birthdate, if: :can_validate_info?

  field :sex, type: String
  validates_presence_of :sex, if: :can_validate_info?

  field :address, type: String
  validates_presence_of :address, if: :can_validate_info?

  field :contactNo, type: String
  validates_presence_of :contactNo, if: :can_validate_info?

  field :email, type: String
  validates_presence_of :email, if: :can_validate_info?
  validates_format_of :email, with: Devise::email_regexp, message: 'is not in valid format', if: :can_validate_info?

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
  field :enrollment_status, type: String
  field :agreed, type: Boolean
  field :reference_no, type: String
  field :finish_enrollment_on, type: DateTime
  field :package_type, type: String

  has_many :invoices, class_name: 'StudentInvoice'

  def middleInitial
    if middleName.nil?
      ''
    else
      middleName.first.capitalize + '.'
    end
  end

  def setup_payment
    season = ReviewSeason.current
    invoice1 = StudentInvoice.new({
                                        package: package_type,
                                        review_season: season,
                                        amount: season.get_fee(package_type),
                                    })
    if package_type == 'Double'
      invoice1.description = 'Invoice 1 of 2'
      invoice2 = StudentInvoice.new({
                                        package: package_type,
                                        description: 'Invoice 2 of 2',
                                        review_season: season,
                                        amount: season.double_review - season.full_review
                                    })
    end

    self.invoices << invoice1
    self.invoices << invoice2 if invoice2
    save
  end

  def current_invoice
    invoices.sort_by { |i| i.review_season.season_start }.last
  end

  def current_invoices
    if invoices
      invoices.where({review_season: current_invoice.review_season})
    end
  end

  def total_current_amount
    current_invoices.reduce(0) { |sum, i| sum+i.amount }
  end

  def finish_enrollment_process
    self.reference_no = "random reference no."
    self.enrollment_status = ''
    self.finish_enrollment_on = DateTime.now
    save
  end

  private
  def can_validate_info?
    !enrollment_status || enrollment_status.empty? || enrollment_status.eql?('personal_information')
  end

  def can_validate_education?
    !enrollment_status || enrollment_status.empty? || enrollment_status.eql?('education')
  end

  def can_validate_others?
    !enrollment_status || enrollment_status.empty? || enrollment_status.eql?('other_information')
  end
end
