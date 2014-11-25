When /^I am on the new student page$/ do
  visit new_student_path
end

When /^I fill up these student information/ do |table|
  table.raw.each do |name, value, type|
    case type
      when 'text'
        fill_in name, with: value
      when 'select'
        select value, from: name
    end
  end
end

When /^I submit the student form/ do
  all('.save.btn').first.click
end

Then /^I should see (\d+) errors/ do |i|
  expect(all('.error li').count).to eq i.to_i
end

Then /^I should be on the students page$/ do
  expect(current_path).to eq students_path
end

Given /^I am on the students page$/ do
  Student.create!(
      firstName: 'John',
      lastName: 'dela Cruz',
      sex: 'Male',
      address: 'Tacloban City',
      contactNo: '321-444',
      email: 'jdelacruz@gmail.com',
      lastAttended: 'Cebu Institute of Medicine',
      yearGrad: 2014,
      hs: 'St. Marys Academy',
      hsYear: 2006,
      elem: 'Luntad Elem. School',
      elemYear: 2002
  )
  Student.create!(
      firstName: 'Maria',
      lastName: 'dela Cruz',
      sex: 'Male',
      address: 'Tacloban City',
      contactNo: '321-444',
      email: 'maria@gmail.com',
      lastAttended: 'St. Therese School of Medicine',
      yearGrad: 2014,
      hs: 'St. Marys Academy',
      hsYear: 2006,
      elem: 'Luntad Elem. School',
      elemYear: 2002
  )
  visit students_path
end

When(/^I search for "(.*?)"/) do |query|
  fill_in 'q', with: query
  execute_script('$(".search form").submit()')
end

And /^I should see "(.*?)" students$/ do |count|
  expect(page).to have_content "Found #{count} student(s)"
end

When /^I remove a student$/ do
  @count = Student.count
  all('.student .actions a').first.click
  sleep 0.5
  click_on 'Yes'
end

Then /^I should not see the student$/ do
  expect(Student.count).to eq @count - 1
  expect(current_path).to eq students_path
end

When /^I cancel the removal of student$/ do
  @count = Student.count
  all('.student .actions a').first.click
  sleep 0.5
  click_on 'No'
end

Then /^I should see the student$/ do
  expect(Student.count).to eq @count
  expect(current_path).to eq students_path
end

When /^I attach a photo$/ do
  attach_file 'student_profile_pic', "#{Rails.root}/features/fixtures/james.jpg", 'image/jpeg'
end

Then /^I should see the uploaded photo$/ do
  expect(Student.first.has_profile_pic?).to be true
end

Given /^I am on the enrollment package type page$/ do
  ReviewSeason.create!(
      season: 'May 2014',
      season_start: Date.new(2014, 4, 1),
      season_end: Date.new(2014, 4, 5),
      first_timer: 17000,
      repeater: 10000,
      full_review: 17000,
      double_review: 22000,
      coaching: 7000,
      reservation: 3000
  )
  visit enrollment_index_path
end