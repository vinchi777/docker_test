# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def rand_name
  ['Willie', 'Kim', 'Alice', 'Eric', 'John', 'Mary', 'Bob', 'Gloria', 'Franco', 'Sarah', 'Leah'][rand(11)]
end

def rand_last_name
  ['Lopez', 'dela Cruz', 'dela Torre', 'Gutierrez', 'Estrada', 'Chiu', 'Martin', 'Aquino', 'de Veyra', 'Enage', 'Rizal', 'Aguinaldo'][rand(12)]
end

def rand_sex
  ['Male', 'Female'][rand(2)]
end

def rand_schools
  ['University of the Philippines', 'Adamson University', 'National University', 'dela Salle Univeristy', 'Far East University'][rand(5)]
end

def rand_address
  street = ['Policarpio', 'Burgos', 'Magsaysay', 'Gomez', 'Rizal', 'Real'][rand(6)] + ' St.'
  mun = ['Tacloban City', 'Palo', 'Tanauan', 'Ormoc City', 'Baybay City', 'Tolosa'][rand(6)]
  province = ['Leyte', 'Southern Leyte', 'Cebu', 'Bohol', 'Palawan', 'Masbate'][rand(6)]
  "#{street}, #{mun}, #{province}"
end

def rand_student
  Student.create(
      firstName: rand_name,
      lastName: rand_last_name,
      middleName: rand_last_name,
      sex: rand_sex,
      address: rand_address,
      contactNo: '321-444',
      email: 'jkdeveyra@gmail.com',
      lastAttended: rand_schools,
      yearGrad: 2014,
      hs: 'St. Marys Academy',
      hsYear: 2006,
      elem: 'Luntad Elem. School',
      elemYear: 2002
  )
end

s = rand_student
s.email = 'admin@example.com'
s.save

User.create(password: '123456789', person: s)

30.times {
  rand_student
}
