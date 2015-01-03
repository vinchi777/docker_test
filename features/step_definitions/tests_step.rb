Given /I am on the tests page/ do
  visit grades_path
end

When /I click the add test link/ do
  find('.new-test', match: :first).click
end

When /I save the test form/ do
  click_on 'Save'
end

Then /the test should be persisted/ do
  sleep 0.2
  expect(Test.exists?).to be true
end

Then /I should be on the test page/ do
  expect(current_path).to eq test_path(Test.first)
end

Given /enrolled students exists for the current season/ do
  @students = []
  @students << StudentFactory.create_student('Erik', true, true)
  @students << StudentFactory.create_student('Bob', true, true)
end

Given /a test exists( and published)?$/ do |flag|
  step 'a review season exists'
  @test = TestFactory.test(false, flag.present?)
end

Given /a test exists and past the deadline/ do
  step 'a review season exists'
  @test = TestFactory.test(false, true, true)
  @sheet = @user.reload.person.current_enrollment.answer_sheets.first
end

When /I click on the test/ do
  find("#test-#{@test.id} a", match: :first).click
end

Then /I should see all students selected/ do
  len = ReviewSeason.first.enrolled_students.length
  expect(all('a.student.selected', count: len).count).to eq len
end

Then /I should( not)? see the student select modal/ do |arg|
  sleep 0.2
  expect(find('#students-select-modal').visible?).to be true if arg.nil?
  expect(find('#students-select-modal', visible: false).visible?).to be false if arg.present?
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
  sleep 0.2
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

Then /I should( not)? see the test/ do |neg|
  if neg
    expect(page).not_to have_css "#test-#{@test.id}"
  else
    expect(page).to have_css "#test-#{@test.id}"
    expect(page).to have_content @test.description
    expect(page).to have_content @test.date.strftime('%b %-d, %Y')
  end
end

Given /I am enrolled for the current season/ do
  @user.person.current_enrollment.enroll
end

Given /a test with(out)? timer exists and published/ do |flag|
  timer = flag.nil?
  @test = TestFactory.test(timer = timer, published = true)
  @sheet = @user.reload.person.current_enrollment.answer_sheets.first
end

When /I am on the student grade page/ do
  visit grades_tests_student_path(@user.person)
end

Then /I should see this answer sheet/ do
  expect(page).to have_content '1'
  expect(page).to have_content 'First long exam'
  expect(page).to have_content @sheet.date.strftime('%b %-d, %Y')
  expect(page).to have_css '.timer-on' if @sheet.test.timer?
  expect(page).to have_css '.timer-off' unless @sheet.test.timer?
end

Then /I can take on the answer sheet/ do
  find("#sheet-#{@sheet.id} a").click
  expect(current_path).to eq answer_sheet_path(@sheet)
end

Then /I should( not)? see the timer/ do |flag|
  expect(page).to have_css '.timer' if flag.nil?
  expect(page).not_to have_css '.timer' unless flag.nil?
end

When /I am on the answer sheet/ do
  @sheet = @user.reload.person.current_enrollment.answer_sheets.first
  visit answer_sheet_path(@sheet)
end

When /I fill up the answer sheet/ do |data|
  data.rows.each do |row|
    find("#question-#{row[0]} .choice#{row[1]}").set true
  end
end

When /I submit the answer sheet/ do
  find('input.submit').click
end

Then /I should not be able to fill up the answer sheet/ do
  expect(page).to have_css 'input.choice1:disabled'
  expect(page).to have_css 'input.choice2:disabled'
  expect(page).to have_css 'input.choice3:disabled'
  expect(page).to have_css 'input.choice4:disabled'
end

Then /I should not be able to submit the answer sheet/ do
  expect(page).not_to have_css 'input.submit'
end

Then /I should see my answers/ do
  expect(page).to have_css 'input:checked'
end

Then /I should see message to wait for results after deadline/ do
  expect(page).to have_content 'Awaiting result after deadline'
end

When /I wait for the timer to end/ do
  @sheet.start_time = Time.now - @sheet.test.timer.minute + 1.seconds
  @sheet.save
  find('#question-1 .choice1').set true
end

When /I took the test/ do
  step 'I am on the answer sheet'
  find('#question-1 .choice1').set true
  find('#question-2 .choice2').set true
  find('#question-3 .choice1').set true
  find('#question-4 .choice1').set true
  step 'I submit the answer sheet'
end

When /I wait until the deadline/ do
  @test = @sheet.reload.test if @sheet
  @test.deadline = Time.now
  @test.save
end

Then /I should see (\d+) out of (\d+) score of the test/ do |correct, total|
  expect(page).to have_content "#{correct} / #{total}"
end

Then /I should see (\d+) out of (\d+) correct answers/ do |correct, total|
  c = correct.to_i
  t = total.to_i
  expect(all('span.correct', count: t).count).to eq t
  expect(all('span.wrong', count: c).count).to eq c
end

Then /I should see the rationalizations/ do
  expect(all('.rationale', count: 4).count).to eq 4
end

When /I try to take the test/ do
  find("#grade-#{@sheet.id}").click
end

When /students take the exam/ do
  answer @test.answer_sheets[0], false
  answer @test.answer_sheets[1], true
end

Then /I can see passing rate/ do
  expect(page).to have_content('%.1f' % @test.passing_rate)
end

Then /I can see students score/ do
  @test.answer_sheets.each do |s|
    expect(page).to have_content "#{s.student.last_name}, #{s.student.first_name}"
    expect(page).to have_content s.correct_points
  end
end

Given /a test from last season exists/ do
  @test = TestFactory.test(false, true, true)
  @test.review_season = ReviewSeason.previous
  @test.save
end

Then /a duplicated test should be created/ do
  current = ReviewSeason.current
  dup = current.tests.first
  expect(dup).not_to be_nil
  expect(dup.description).to eq @test.description
  expect(dup.date).to eq Date.today
  expect(dup.deadline).to eq current.season_end.to_time
  expect(dup.timer).to eq @test.timer
  expect(dup.questions).to match_array(@test.questions)
end

Then /I should be on the duplicated test page/ do
  dup = ReviewSeason.current.tests.first
  expect(current_path).to eq test_path(dup)
end

Given /the test is duplicated to the current season/ do
  @test.copy
end

When /I click on the remove test button/ do
  find("#test-#{@test.id} a.remove", match: :first).click
end

Then /the test should( not)? exist/ do |neg|
  expect(Test.empty?).to be false unless neg
  expect(Test.empty?).to be true if neg
end

When /I select for "(.*?)" in student select/ do |name|
  fill_in 'q', with: name
  find('a.student', match: :first).click
end

Then /I should see other students in student select/ do
  expect(page).to have_content '1 of 1 student'
end

def answer(sheet, pass)
  sheet.answers.each do |a|
    if pass
      a.index = a.question.answer
    else
      a.index = 0 if a.question.answer != 0
      a.index = 1 if a.question.answer == 0
    end
    a.save
  end
end