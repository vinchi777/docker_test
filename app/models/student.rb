class Student
  include Mongoid::Document

  field :firstName, type: String
  validates_presence_of :firstName

  field :middleName, type: String

  field :lastName, type: String
  validates_presence_of :lastName

  field :birthdate, type: Date, default: Date.today
  validates_presence_of :birthdate

  field :sex, type: String
  validates_presence_of :sex

  field :address, type: String
  validates_presence_of :address

  field :contactNo, type: String
  validates_presence_of :contactNo

  field :email, type: String
  validates_presence_of :email
  validates_format_of :email, with: Devise::email_regexp, message: 'is not in valid format'

  field :parentFirstName, type: String
  field :parentLastName, type: String
  field :parentContact, type: String

  field :lastAttended, type: String
  validates_presence_of :lastAttended

  field :yearGrad, type: Integer
  validates_presence_of :yearGrad
  validates_numericality_of :yearGrad, greater_than: :hsYear, message: 'must be later than High School Year'

  field :recognition, type: String
  field :hs, type: String
  validates_presence_of :hs

  field :hsYear, type: Integer
  validates_presence_of :hsYear
  validates_numericality_of :hsYear, greater_than: :elemYear, message: 'must be later than Elementary Year'

  field :elem, type: String
  validates_presence_of :elem

  field :elemYear, type: Integer
  validates :elemYear, presence: true

  field :referrerFirstName, type: String
  field :referrerLastName, type: String
  field :referrerContact, type: String

  field :why, type: String
  field :facebook, type: String
  field :twitter, type: String
  field :linkedin, type: String


  def middleInitial
    if middleName.nil?
      ''
    else
      middleName.first.capitalize + '.'
    end
  end

  has_many :invoices, class_name: 'StudentInvoice'
end
