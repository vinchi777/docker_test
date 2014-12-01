Before('@admin') do
  p = Person.create(firstName: 'John', lastName: 'dela Cruz', email: 'admin@example.com')
  User.create(password: '123456789', person: p, confirmed_at: Date.new)
  visit '/login'
  fill_in 'user_email', with: 'admin@example.com'
  fill_in 'user_password', with: '123456789'
  click_on 'Log in'
  sleep 0.5
end