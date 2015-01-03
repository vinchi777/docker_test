When /users exists$/ do
  UserFactory.users
end

When /I am on the users page/ do
  visit users_path
end

And /^I should see (.*?) users$/ do |count|
  c = count.to_i
  expect(page).to have_content "Found #{count} " + 'user'.pluralize(c)
  expect(all('.users .user', count: c).count).to eq c
end

And /I should see unconfirmed student/ do
  expect(page).to have_content 'Unconfirmed'
end

And /email should( not)? be sent to "(.*?)"/ do |neg, email|
  emails = ActionMailer::Base.deliveries
  if neg.nil?
    expect(emails.size).to eq 1
    expect(emails.first.to).to eq [email]
  else
    expect(emails.size).to eq 0
  end
end

Then /the user password should be updated/ do
  sleep 0.2
  expect(User.first.valid_password? 'password123').to be true
end

Given /I am on the change password page/ do
  visit change_password_users_path
  @user = User.find_by(email: 'student@example.com')
end

When /I click the user icon/ do
  find('a.no-user', match: :first).click
end

Then /a user should be created/ do
  sleep 0.2
  expect(User.count).to eq 2
end

Given /a student user exists/ do
  @user = UserFactory.student
  @person = @user.person
end

Given /an admin user exists/ do
  @user = UserFactory.create 'Mark', 'dela Cruz', 'mark@example.com'
  @person = @user.person
end

When /I remove the user/ do
  find("#user-#{@user.id} .remove a", match: :first).click
  click_on 'Yes'
end

Then /the person should( not)? be removed/ do |neg|
  expect(Person.where(id: @person.id).exists?).not_to be neg.nil?
end