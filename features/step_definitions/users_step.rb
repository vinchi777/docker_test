When /users exists$/ do
  UserFactory.users
end

When /I am on the users page/ do
  visit users_path
  @user = User.first
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
  expect(@user.reload.valid_password? 'password123').to be true
end

Given /I am on the change password page/ do
  visit change_password_users_path
  @user = User.find_by(email: 'student@example.com')
end