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
  StudentFactory.create_student 'Erik', true, true
  StudentFactory.create_student 'Bob', true, true
end

Given /a test exists/ do
  step 'a review season exists'
  @test = Test.create!(
      description: 'First long exam',
      date: Date.parse('Feb. 1, 2014'),
      deadline: Date.parse('Feb. 1, 2014') + 1.day,
      timer: 30,
      review_season: ReviewSeason.first
  )
end

When /I click on the test/ do
  find("#test-#{@test.id} a").click
end

Then /I should see all students selected/ do
  len = ReviewSeason.first.enrolled_students.length
  expect(all('a.student.selected', count: len).count).to eq len
end

Then /I should(.*?) see the student select modal/ do |arg|
  expect(find('#students-select-modal', visible: false).visible?).to be !arg.present?
end

Then /the students have answer sheets/ do
  expect(ReviewSeason.first.enrolled_students.size).not_to eq 0
  ReviewSeason.first.enrolled_students do |s|
    expect(@test.has_answer_sheet? s).to be true
  end
end

When /I search for "(.*?)" in student select/ do |q|
  fill_in 'q', with: q
end

When /^I deselect all students$/ do
  find('a.toggle').click
end

Then /I should see (\d+) student for selection/ do |i|
  expect(all('a.student', count: i.to_i).count).to eq i.to_i
end

Then /"(.*?)" should have answer sheet/ do |i|
  sleep 0.5
  @bob = Student.where(first_name: i).first
  expect(@test.has_answer_sheet? @bob).to eq true
end

Given /I am on the test page/ do
  visit test_path(@test)
end

Then /the test should be updated/ do
  @test.reload
  expect(@test.description).to eq @params[:description]
  expect(@test.date).to eq DateTime.parse(@params[:date])
  expect(@test.deadline).to eq Time.parse(@params[:deadline])
  expect(@test.questions[0].text).to eq @params[:question_0_text]
  expect(@test.questions[0].choice1).to eq @params[:question_0_choice0]
end

When /^select the student$/ do
  find('a.student', match: :first).click
end

Then /other students should(.*?) have answer sheets/ do |arg|
  Student.not.where(id: @bob.id).each do |s|
    expect(@test.has_answer_sheet? s).not_to eq true
  end
end

Then /I should see the test/ do
  expect(page).to have_content @test.description
  expect(page).to have_content @test.date.strftime('%b %-d, %Y')
end
