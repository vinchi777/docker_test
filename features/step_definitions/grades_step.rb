Given /^A review season exists$/ do
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
end

Given /^Students exists$/ do
  StudentFactory.create_student('maria')
  StudentFactory.create_student('jk', true, false)
  StudentFactory.create_student('abc', true, true)
  StudentFactory.create_student('def', true, true)
end

Given /^I am on the grades page$/ do
  visit grades_path
end

And /^I click the add grade link$/ do
  find('.new-grade').click
end

Then /^I should be redirected to the new grade page$/ do
  expect(current_path).to eq new_grade_path
end

When /^I fill in the following "(.*?)" details$/ do |pre, data|
  data.rows.each do |row|
    name = "#{pre}[#{row[0]}]"
    case row[2]
      when 'text'
        fill_in name, with: row[1]
      when 'select'
        select row[1], from: name
      when 'check'
        check row[1]
      when 'uncheck'
        uncheck row[1]
      when 'choose'
        choose row[1]
    end
  end
end

And /^I submit the grade form$/ do
  click_button 'Save'
end

Then /^I should successfully add the "(.*?)" grade$/ do |grade|
  expect(Grade.where(description: grade).count).to eq 1
end

Then /^I should be redirected to the grades page$/ do
  expect(current_path).to eq grades_path
end

Given /^I am on the new grade page$/ do
  visit new_grade_path
end

Then /^I should see (\d+) students$/ do |count|
  expect(all('.student-list tr').count).to eq count.to_i
end

And /^I fill up the following student grades$/ do |data|
  data.rows.each_with_index do |row, i|
    fill_in "grade[student_grades_attributes][#{i}][score]", with: row[0]
  end
end

And /^I should (.*?)see a grade with an average of (\d+)$/ do |inverse, grade|
  has_grade = false
  all('.point-wrapper .inline').each do |w|
    has_grade = true if w.has_content? grade
  end
  expect(has_grade).to eq inverse.empty?
end