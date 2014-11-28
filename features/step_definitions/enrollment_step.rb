When /^I select "(.*?)"$/ do |radio|
  choose radio
end

Then /^The student should be for confirmation$/ do
  s = Student.find_by(email: 'john@gmail.com')
  expect(s.enrollment_status).to eq :enrolling
end

Given /^I am on the pricing page$/ do
  visit pricing_path
end

When /^I select the "(.*?)" package$/ do |package|
  case package
    when 'Final Coaching'
      scope = '.coaching-package'
    when 'Standard Package'
      scope = '.standard-package'
    when 'Double Review'
      scope = '.double-package'
  end
  find(scope).click_link 'Enroll'
end

Then /^I should skip the enrollment package step$/ do
  expect(page).to have_content('Personal Information')
end

Then /^should be enrolled for the "(.*?)" package$/ do |package|
  case package
    when 'Final Coaching'
      p = 'Coaching'
    when 'Standard Package'
      p = 'Standard'
    when 'Double Review'
      p = 'Double'
  end
  expect(find('#student_package_type',visible: false).value).to eq p
end