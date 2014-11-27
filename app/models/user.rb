class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable, :confirmable

  ## Database authenticatable

  # A copy of email from Person. Do not modify since this will be overridden on save.
  field :email, type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  # field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at, type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String

  ## Person cached fields
  field :first_name, type: String
  field :last_name, type: String
  field :middle_initial, type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  has_one :person
  validates_presence_of :person

  before_validation do |d|
    d.email = d.person.email
    d.first_name = d.person.firstName
    d.last_name = d.person.lastName
    d.middle_initial = d.person.middle_initial
  end

  def self.serialize_into_session(record)
    [record.id.to_s, record.authenticatable_salt]
  end

  def as_json(opt = nil)
    hash = self.serializable_hash(nil)
    hash[:id] = id.to_s
    hash[:confirmed] = !confirmed_at.nil?
    hash[:last_sign_in_at] = last_sign_in_at
    hash[:current_sign_in_at] = current_sign_in_at
    hash.as_json(nil)
  end
end
