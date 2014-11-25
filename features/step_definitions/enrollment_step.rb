When /^I select "(.*?)"$/ do |radio|
  choose radio
end

Then /^The student should be for confirmation$/ do
  s = Student.find_by(email: 'john@gmail.com')
  expect(s.enrollment_status).to eq :enrolling
end