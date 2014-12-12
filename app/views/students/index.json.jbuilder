json.totalSize @size
json.students @students do |s|
  json.id s.id.to_s
  json.profile_pic s.profile_pic
  json.last_name s.last_name
  json.first_name s.first_name
  json.middle_initial s.middle_initial
  json.email s.email
  json.last_attended s.last_attended
  json.address s.address
  json.user_id s.user.id if s.user
  json.enrollment_status s.enrollment_status
  json.current_season s.current_season.season if s.current_season
  json.balance s.balance
end
