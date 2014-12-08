class Person
  include Mongoid::Document

  field :first_name, type: String
  validates_presence_of :first_name

  field :middle_name, type: String
  field :last_name, type: String
  validates_presence_of :last_name

  field :birthdate, type: Date, default: Date.today
  field :sex, type: String
  field :address, type: String
  field :contact_no, type: String
  field :email, type: String
  validates_uniqueness_of :email
  validates_format_of :email, with: Devise::email_regexp, message: 'is not in valid format'

  belongs_to :user

  before_validation do |d|
    d.email = d.email.downcase
  end

  def middle_initial
    if middle_name.nil?
      ''
    else
      middle_name.first.capitalize + '.'
    end
  end

  def to_s
    "#{last_name}, #{first_name} #{middle_name}"
  end

  def trailing_name
    ", #{first_name} #{middle_name}"
  end
end
