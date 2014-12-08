Given /I am on the tests page/ do
  visit grades_path
end

When /I click the add test link/ do
  find('.new-test', match: :first).click
end

When /I save the test form/ do
  click_on 'Save'
end

Then /the test is persisted/ do
  expect(Test.exists?).to be true
end

Then /I should be on the test page/ do
  expect(current_path).to eq test_path(Test.first)
end

Given /enrolled students exists for the current season/ do
  StudentFactory.create_student 'Mark', true, true
end

Given /a test exists/ do
  Test.create!(
      description: 'First long exam',
      date: Date.new,
      deadline: Date.new + 1.day,
      timer: 30,
      review_season: ReviewSeason.first
  )
end

When /I click on the test/ do

end

Then /I should see all students selected/ do

end

Then /I should(.*?) see the student select modal/ do |arg|

end

Then /the students have answer sheets/ do

end

Then /I should see (\d+) student for selection/ do |i|

end

Then /"(.*?)" should have answer sheet/ do |i|

end

Then /other students should(.*?) have answer sheets/ do |arg|

end
