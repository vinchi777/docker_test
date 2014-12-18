Then /^I should( not)? see "(.*?)"$/ do |negative, text|
  if negative
    expect(page).not_to have_content text
  else
    expect(page).to have_content text
  end
end

When /^I press the "(.*?)" button$/ do |label|
  click_on label, match: :first
end

When /I click on "(.*?)"/ do |text|
  click_on text, match: :first
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
  UserFactory.admin
  visit '/login'
  fill_in 'user_email', with: 'admin@example.com'
  fill_in 'user_password', with: '123456789'
  click_on 'Log in'
end

Given /^I am logged in as a student/ do
  @user = UserFactory.student
  visit '/login'
  fill_in 'user_email', with: 'student@example.com'
  fill_in 'user_password', with: '123456789'
  click_on 'Log in'
end

Given /^a review season exists$/ do
  if ReviewSeason.empty?
    @season = ReviewSeasonFactory.createOngoing
  else
    @season = ReviewSeason.first
  end
end

Given /^no ongoing review season exists$/ do
  ReviewSeason.delete_all
  @season = ReviewSeasonFactory.createOld
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
  StudentFactory.for_searching
  @student = Student.first
end

Given /^I am on the home page$/ do
  visit home_path
end

Then /^I should be able to search (.*?) by/ do |model, data|
  data.rows.each do |row|
    fill_in 'q', with: row[0]
    execute_script('$(".search form").submit()')
    expect(page).to have_content row[1]
    expect(page).to have_content "Found #{row[2]} " + model.singularize.pluralize(row[2].to_i)
  end
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