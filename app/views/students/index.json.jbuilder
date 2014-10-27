json.array!(@students) do |student|
  json.extract! student, :id, :firstName, :middleName, :lastName, :birthdate, :sex, :address, :contactNo, :email, :parentFirstName, :parentLastName, :parentContact, :lastAttended, :yearGrad, :recognition, :hs, :hsYear, :elem, :elemYear, :referrerFirstName, :referrerLastName, :why, :facebook, :twitter, :linkedin
  json.url student_url(student, format: :json)
end
