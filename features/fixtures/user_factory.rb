class UserFactory
  def self.users
    create 'John', 'dela Cruz', 'jdelacruz@yahoo.com'
    create 'Erik', 'Mayers', 'erik_mayers@yahoo.com'
    create 'Maria', 'dela Cruz', 'maria_delacruz@gmail.com'
  end

  def self.create(first_name, last_name, email)
    s = Person.create!(first_name: first_name, last_name: last_name, email: email, civil_status: :single)
    User.create!(password: '123456789', person: s, confirmed_at: Date.new)
  end
end