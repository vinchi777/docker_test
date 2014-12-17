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