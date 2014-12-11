Then /^I should( not)? see "(.*?)"$/ do |negative, text|
  if negative
    expect(page).not_to have_content text
  else
    expect(page).to have_content text
  end
end

When /^I press the "(.*?)" button$/ do |label|
  click_on label
end

Then /^I should be on the homepage$/ do
  expect(current_path).to eq root_path
end

When /^I fill up these (.*?) information$/ do |p, data|
  @attributes = Set.new
  @params = Hash.new
  pre = p.parameterize.underscore
  data.rows.each do |row|
    attr = row[0].parameterize.underscore
    val = row[1]
    @params[:"#{attr}"] = val if val.present?
    @attributes << attr
    name = "#{pre}[#{attr}]"
    case row[2].parameterize.underscore
      when 'text'
        if pre == 'test' && attr == 'question_0_ratio' # Add rationale
          all('.add-rationale').each { |l| l.click }
        end
        sleep 0.1
        fill_in name, with: ''
        fill_in name, with: val
      when 'select'
        select val, from: name
      when 'check'
        check name
      when 'uncheck'
        uncheck name
      when 'choose'
        choose name
    end
  end
end

Given /^I am logged in as admin$/ do
  p = Person.create(first_name: 'John', last_name: 'dela Cruz', email: 'admin@example.com')
  User.create(password: '123456789', person: p, confirmed_at: Date.new)
  visit '/login'
  fill_in 'user_email', with: 'admin@example.com'
  fill_in 'user_password', with: '123456789'
  click_on 'Log in'
end

Given /^I am logged in as a student/ do
  p = StudentFactory.create_student('Mary', true, false)
  p.email = 'student@example.com'
  @user = User.create(password: '123456789', person: p, confirmed_at: Date.new)
  visit '/login'
  fill_in 'user_email', with: 'student@example.com'
  fill_in 'user_password', with: '123456789'
  click_on 'Log in'
end

Given /^a review season exists$/ do
  if ReviewSeason.empty?
    @season = ReviewSeason.create!(
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
  else
    @season = ReviewSeason.first
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
      first_name: 'John',
      last_name: 'dela Cruz',
      sex: 'Male',
      civil_status: 'Single',
      address: 'Tacloban City',
      contact_no: '321-444',
      email: 'jdelacruz@gmail.com',
      last_attended: 'Cebu Institute of Medicine',
      college_year: 2014,
      hs: 'St. Marys Academy',
      hs_year: 2006,
      elem: 'Luntad Elem. School',
      elem_year: 2002
  )
  Student.create!(
      first_name: 'Maria',
      last_name: 'dela Cruz',
      sex: 'Male',
      civil_status: 'Single',
      address: 'Tacloban City',
      contact_no: '321-444',
      email: 'maria@gmail.com',
      last_attended: 'St. Therese School of Medicine',
      college_year: 2014,
      hs: 'St. Marys Academy',
      hs_year: 2006,
      elem: 'Luntad Elem. School',
      elem_year: 2002
  )
  @student = Student.first
end

Given /^I am on the home page$/ do
  visit home_path
end

def expect_updated(a, b)
  keys = Set.new
  b.each do |k, v|
    keys << k if a[k] != v
  end
  @attributes.each do |k|
    expect(keys).to include k
  end
end