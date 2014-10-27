class Student
  include Mongoid::Document

  field :firstName, type: String
  field :middleName, type: String
  field :lastName, type: String
  field :birthdate, type: Date
  field :sex, type: Boolean
  field :address, type: String
  field :contactNo, type: String
  field :email, type: String
  field :parentFirstName, type: String
  field :parentLastName, type: String
  field :parentContact, type: String

  field :lastAttended, type: String
  field :yearGrad, type: Date
  field :recognition, type: String
  field :hs, type: String
  field :hsYear, type: Date
  field :elem, type: String
  field :elemYear, type: Date
  field :referrerFirstName, type: String
  field :referrerLastName, type: String
  field :why, type: String
  field :facebook, type: String
  field :twitter, type: String
  field :linkedin, type: String
end
