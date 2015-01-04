s = Person.create!(first_name: 'Admin', last_name: 'Admin', email: 'maxrevone@gmail.com', civil_status: :single)
User.create!(password: '123456789', person: s, confirmed_at: Date.new)