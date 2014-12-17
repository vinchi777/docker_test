When /users exists$/ do
  UserFactory.users
end

When /I am on the users page/ do
  visit users_path
end

