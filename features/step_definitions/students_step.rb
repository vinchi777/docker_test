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
  click_on 'save-btn'
end

Then /^I should see (\d+) errors/ do |i|
  expect(all('.error li').count).to eq i.to_i
end

Then /^I should be on the students page$/ do
  expect(current_path).to eq students_path
end

Given /^I see students for searching$/ do
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
end

Given /^I am on the students page$/ do
  visit students_path
end

When(/^I search for "(.*?)"/) do |query|
  fill_in 'q', with: query
  execute_script('$(".search form").submit()')
end

And /^I should see "(.*?)" students$/ do |count|
  expect(page).to have_content "Found #{count} student(s)"
end