json.studentenrollments @enrollments do |e|
  json.id e.id.to_s
  json.profile_pic e.student.profile_pic
  json.last_name e.student.last_name
  json.first_name e.student.first_name
  json.middleInitial e.student.middle_initial
end
