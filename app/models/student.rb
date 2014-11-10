class Student
  include Mongoid::Document

  field :firstName, type: String
  validates_presence_of :firstName, if: :personal_info_step?

  field :middleName, type: String

  field :lastName, type: String
  validates_presence_of :lastName, if: :personal_info_step?

  field :birthdate, type: Date, default: Date.today
  validates_presence_of :birthdate, if: :personal_info_step?

  field :sex, type: String
  validates_presence_of :sex, if: :personal_info_step?

  field :address, type: String
  validates_presence_of :address, if: :personal_info_step?

  field :contactNo, type: String
  validates_presence_of :contactNo, if: :personal_info_step?

  field :email, type: String
  validates_presence_of :email, if: :personal_info_step?
  validates_format_of :email, with: Devise::email_regexp, message: 'is not in valid format', if: :personal_info_step?

  field :parentFirstName, type: String
  field :parentLastName, type: String
  field :parentContact, type: String

  field :lastAttended, type: String
  validates_presence_of :lastAttended, if: :education_step?

  field :yearGrad, type: Integer
  validates_presence_of :yearGrad, if: :education_step?
  validates_numericality_of :yearGrad, greater_than: :hsYear, message: 'must be later than High School Year', if: :education_step?

  field :recognition, type: String
  field :hs, type: String
  validates_presence_of :hs, if: :education_step?

  field :hsYear, type: Integer
  validates_presence_of :hsYear, if: :education_step?
  validates_numericality_of :hsYear, greater_than: :elemYear, message: 'must be later than Elementary Year', if: :education_step?

  field :elem, type: String
  validates_presence_of :elem, if: :education_step?

  field :elemYear, type: Integer
  validates :elemYear, presence: true, if: :education_step?

  field :referrerFirstName, type: String
  field :referrerLastName, type: String
  field :why, type: String
  field :facebook, type: String
  field :twitter, type: String
  field :linkedin, type: String
  field :enrollment_status, type: String
  field :agreed, type: Boolean
  field :reference_no, type: String
  field :finish_enrollment_on, type: DateTime
  field :package_type, type: String

  embeds_many :invoices, class_name: 'StudentInvoice'

  def middleInitial
    if middleName.nil?
      ''
    else
      middleName.first.capitalize + '.'
    end
  end

  # def create_invoice
  #   season = ReviewSeason.current
  #   my_invoice = StudentInvoice.new({
  #                                       package: package_type,
  #                                       review_seasons: season.season,
  #                                       amount: season.get_fee(package_type)
  #                                   })
  #   self.invoices << my_invoice
  #   save
  # end
  #
  # def current_invoice
  #   if invoices
  #     invoices.sort_by { |i| ReviewSeason.where(season: i.season).first.season_start }.last
  #   end
  # end

  def finish_enrollment_process
    self.reference_no = "random reference no."
    self.enrollment_status = ''
    self.finish_enrollment_on = DateTime.now
    save
  end

  private
  def personal_info_step?
    enrollment_status.empty? || enrollment_status.eql?('personal_information')
  end

  def education_step?
    enrollment_status.empty? || enrollment_status.eql?('education')
  end

  def other_step?
    enrollment_status.empty? || enrollment_status.eql?('other_information')
  end
end
