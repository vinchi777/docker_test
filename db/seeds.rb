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
  first_name = rand_name
  last_name = rand_last_name
  std = Student.create!(
      first_name: first_name,
      last_name: last_name,
      middle_name: rand_last_name,
      sex: rand_sex,
      address: rand_address,
      contact_no: '321-444',
      email: "#{first_name}_#{last_name.parameterize('_')}@gmail.com",
      last_attended: rand_schools,
      college_year: 2014,
      hs: 'St. Marys Academy',
      hs_year: 2006,
      elem: 'Luntad Elem. School',
      elem_year: 2002
  )
  std.package_type = %w{Standard Double Coaching}[rand(3)]
  std.setup_payment
  std.finish_enrollment_process
  std
end

ReviewSeason.create!(
    season: 'May 2014',
    season_start: Date.new(2014, 4, 1),
    season_end: Date.new(2014, 4, 5),
    first_timer: 17000,
    repeater: 10000,
    full_review: 17000,
    double_review: 22000,
    coaching: 7000,
    reservation: 3000
)

s = rand_student
s.email = 'admin@example.com'
s.save
User.create!(password: '123456789', person: s, confirmed_at: Date.new)



10.times do |i|
  rand_student
end
