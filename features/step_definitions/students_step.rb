When /^I am on the new student page$/ do
  visit new_student_path
end

When /^I fill up the following student information$/ do |table|
  table.raw.each do |name, value, type|
    case type
      when 'text'
        fill_in "student[#{name}]", with: value
      when 'select'
        select value, from: "student[#{name}]"
    end
  end
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

Then /^I should be able to search students by/ do |data|
  data.rows.each do |row|
    fill_in 'q', with: row[0]
    execute_script('$(".search form").submit()')
    expect(page).to have_content row[1]
    expect(page).to have_content "Found #{row[2]} " + 'student'.pluralize(row[2].to_i)
  end
end

Given /students exist for filtering/ do
  StudentFactory.create_student('maria')
  StudentFactory.create_student('jk', true, false)
  StudentFactory.create_student('abc', true, true)
  StudentFactory.create_student('def', true, true)
end