json.studentenrollments @enrollments do |e|
  json.id e.id.to_s
  json.profile_pic e.student.profile_pic
  json.lastName e.student.lastName
  json.firstName e.student.firstName
  json.middleInitial e.student.middle_initial
end
