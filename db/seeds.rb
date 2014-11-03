# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'admin@example.com', password: '123456789')

15.times {
  Student.create(
      firstName: 'JK',
      lastName: 'de Veyra',
      sex: true,
      address: 'Brgy. San Miguel, Palo, Leyte',
      contactNo: '321-444',
      email: 'jkdeveyra@gmail.com',
      lastAttended: 'University of the Philippines',
      yearGrad: Date.today,
      hs: 'St. Marys Academy',
      hsYear: Date.today,
      elem: 'Luntad Elem. School',
      elemYear: Date.today
  )
}
