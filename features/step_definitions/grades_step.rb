Given /^I am on the grades page$/ do
  visit grades_path
end

And /^I click the add grade link$/ do
  find('.new-grade').click
end

Then /^I should be redirected to the new grade page$/ do
  expect(current_path).to eq new_grade_path
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

And /^I should(.*?) see a grade with an average of (\d+)$/ do |inverse, grade|
  has_grade = false
  all('.point-wrapper .inline').each do |w|
    has_grade = true if w.has_content? grade
  end
  expect(has_grade).to eq inverse.empty?
end

Then /^I should be able to search for the following student queries$/ do |data|
  data.rows.each do |row|
    fill_in 'q', with: row[0]
    s = all('.student-list tr', count: row[1].to_i)
    expect(s.count).to eq row[1].to_i
  end
end

Given /^No review season exists$/ do
  ReviewSeason.destroy_all
end

When /^I click the edit students icon$/ do
  find('.edit-students').click
end

Then /^I should see the select students modal$/ do
  expect(find('#students-select-modal').visible?).to eq true
end

When /^I click the (de)?select all icon$/ do |deselect|
  if deselect
    find('#students-select-modal .fa-circle-o').click
  else
    find('#students-select-modal .fa-check-circle-o').click
  end
end

Then /^all students should be (de)?selected$/ do |deselected|
  count = all('#students-select-modal .student.excluded').size
  if deselected
    expect(count).to eq 2
  else
    expect(count).to eq 0
  end
end

When /^I deselect "(.*?)" at the student select modal$/ do |student|
  find("#students-select-modal .student[data-query='#{student}']").click
end

Then /^I should not see the select indicator on "(.*?)"$/ do |student|
  expect(all("#students-select-modal .student.excluded[data-query='#{student}']").size).to eq 1
end

Then /^I should search for the following students in the select modal$/ do |data|
  data.rows.each do |row|
    fill_in 'student_q', with: row[0]
    s = all("#students-select-modal .student", count: row[1].to_i)
    expect(s.count).to eq row[1].to_i
  end
end

And /^the grade should only contain (\d+) student grade$/ do |count|
  expect(Grade.first.student_grades.size).to eq count.to_d
end

Given /^a grade exists$/ do
  enrs = StudentEnrollment.all
  Grade.create!({
                    description: 'NLE Examination',
                    date: DateTime.now,
                    points: 50,
                    review_season: ReviewSeason.current,
                    student_grades_attributes: [
                        {score: 50, student_enrollment: enrs.first},
                        {score: 49, student_enrollment: enrs.last}
                    ]
                })
end

When /^I click the first existing grade$/ do
  all('.grade')[0].click
end