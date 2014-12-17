When /^I am on the new student page$/ do
  visit new_student_path
end

When /^I save the student form/ do
  first('.save.btn').click
end

Then /^I should see (\d+) errors/ do |i|
  expect(all('.error li', count: i.to_i).count).to eq i.to_i
end

Then /^I should be on the students page$/ do
  expect(current_path).to eq students_path
end

Given /^I am on the students page$/ do
  visit students_path
end

When /^I search for "(.*?)"$/ do |query|
  fill_in 'q', with: query
  execute_script('$(".search form").submit()')
end

And /^I should see "(.*?)" students$/ do |count|
  expect(page).to have_content "Found #{count} " + 'student'.pluralize(count.to_i)
end

When /^I remove a student$/ do
  @count = Student.count
  find('.student .actions a', match: :first).click
  click_on 'Yes'
end

Then /^I should not see the student$/ do
  expect(current_path).to eq students_path
  expect(Student.count).to eq @count - 1
end

When /^I cancel the removal of student$/ do
  @count = Student.count
  find('.student .actions a', match: :first).click
  click_on 'No'
end

Then /^I should see the student$/ do
  expect(Student.count).to eq @count
  expect(current_path).to eq students_path
end

When /^I attach a photo$/ do
  attach_file 'student_profile_pic', "#{Rails.root}/features/fixtures/james.jpg", 'image/jpeg'
end

When /^I choose "(.*?)" season and "(.*?)" type$/ do |season, type|
  select season, from: 'season'
  select type, from: 'type'
end

Then /^I should see the uploaded photo$/ do
  expect(Student.first.has_profile_pic?).to be true
end

Given /^I am on the enrollment package type page$/ do
  visit enrollment_index_path
end

Given /students exist for filtering/ do
  StudentFactory.create_student('maria')
  StudentFactory.create_student('jk', true, false)
  StudentFactory.create_student('abc', true, true)
  StudentFactory.create_student('def', true, true)
end

Given /an enrolling student exists/ do
  @student = StudentFactory.create_student('John', true, false)
end

Then /I should see the student is enrolled/ do
  @season = ReviewSeason.first
  expect(page).to have_content "Enrolled for #{@season.season}"
end

Then /the student is confirmed/ do
  expect(@student.reload.enrolled?).to be true
end

Given /I am on the student page/ do
  visit student_path(@student)
end

Given /students exist with balance/ do
  @students = []
  @students << StudentFactory.create_student('Maria', true, true)
  @students << StudentFactory.create_student('Erik', true, true)
end

Then /I should see names, email, last school, address and balance of the students/ do
  @students.each do |s|
    expect(page).to have_content s.to_s
    expect(page).to have_content s.last_attended
    expect(page).to have_content s.address
    expect(page).to have_content '15,000' if s.has_balance?
  end
end

Then /the student should be updated/ do
  expect_updated @student.attributes, @student.reload.attributes
end

When /student pay at least the reservation fee$/ do
  @student.current_invoice.transactions.create(
      date: Date.today,
      or_no: '1234560',
      method: 'Cash',
      amount: ReviewSeason.current.reservation
  )
end