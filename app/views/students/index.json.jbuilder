json.totalSize @size
json.students @students do |s|
  json.id s.id.to_s
  json.profile_pic s.profile_pic
  json.last_name s.last_name
  json.first_name s.first_name
  json.middle_initial s.middle_initial
  json.email s.email
  json.lastAttended s.lastAttended
  json.address s.address
  json.user_id s.user_id
  json.enrollment_status s.enrollment_status
  json.current_season s.current_season
  json.balance s.balance
end
