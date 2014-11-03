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

  field :parentFirstName, type: String
  field :parentLastName, type: String
  field :parentContact, type: String

  field :lastAttended, type: String
  validates_presence_of :lastAttended

  field :yearGrad, type: Integer
  validates :yearGrad, presence: true
  validates_numericality_of :yearGrad, greater_than: :hsYear

  field :recognition, type: String
  field :hs, type: String
  validates_presence_of :hs

  field :hsYear, type: Integer
  validates :hsYear, presence: true
  validates :hsYear, numericality: {greater_than: :elemYear}

  field :elem, type: String
  validates_presence_of :elem, presence: true

  field :elemYear, type: Integer
  validates :elemYear, presence: true

  field :referrerFirstName, type: String
  field :referrerLastName, type: String
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

  embeds_many :payments, class_name: 'StudentPayment'
end
