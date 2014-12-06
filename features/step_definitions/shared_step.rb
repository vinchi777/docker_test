Then /^I should see "(.*?)"$/ do |text|
  expect(page).to have_content text
end

When /^I press the "(.*?)" button$/ do |label|
  click_on label
end

Then /^I should be on the homepage$/ do
  expect(current_path).to eq root_path
end

Given /^I am logged in as admin$/ do
  p = Person.create(firstName: 'John', lastName: 'dela Cruz', email: 'admin@example.com')
  User.create(password: '123456789', person: p, confirmed_at: Date.new)
  visit '/login'
  fill_in 'user_email', with: 'admin@example.com'
  fill_in 'user_password', with: '123456789'
  click_on 'Log in'
end

Given /^a review season exists$/ do
  if ReviewSeason.empty?
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
end

Given /^students exist$/ do
  step 'a review season exists'
  StudentFactory.create_student('maria')
  StudentFactory.create_student('jk', true, false)
  StudentFactory.create_student('abc', true, true)
  StudentFactory.create_student('def', true, true)
  @student = Student.first
end

Given /students exist for searching/ do
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
  @student = Student.first
end