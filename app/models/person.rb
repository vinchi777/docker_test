class Person
  include Mongoid::Document

  field :firstName, type: String
  validates_presence_of :firstName

  field :middleName, type: String
  field :lastName, type: String
  validates_presence_of :lastName

  field :birthdate, type: Date, default: Date.today
  field :sex, type: String
  field :address, type: String
  field :contactNo, type: String
  field :email, type: String
  validates_uniqueness_of :email
  validates_format_of :email, with: Devise::email_regexp, message: 'is not in valid format'

  belongs_to :user

  def middle_initial
    if middleName.nil?
      ''
    else
      middleName.first.capitalize + '.'
    end
  end

  def to_s
    "#{lastName}, #{firstName} #{middleName}"
  end
end
