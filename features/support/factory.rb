Before '@student_list' do
  Student.create!(
      firstName: 'John',
      lastName: 'dela Cruz',
      sex: 'Male',
      address: 'Tacloban City',
      contactNo: '321-444',
      email: 'jdelacruz@gmail.com',
      lastAttended: 'Cebu Institute of Medicine',
      yearGrad: 2014,
      hs: 'St. Marys Academy',
      hsYear: 2006,
      elem: 'Luntad Elem. School',
      elemYear: 2002
  )
  Student.create!(
      firstName: 'Maria',
      lastName: 'dela Cruz',
      sex: 'Male',
      address: 'Tacloban City',
      contactNo: '321-444',
      email: 'maria@gmail.com',
      lastAttended: 'St. Therese School of Medicine',
      yearGrad: 2014,
      hs: 'St. Marys Academy',
      hsYear: 2006,
      elem: 'Luntad Elem. School',
      elemYear: 2002
  )
end

Before '@student_list_for_filter' do
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
  StudentFactory.create_student('maria')
  StudentFactory.create_student('jk', true, false)
  StudentFactory.create_student('abc', true, true)
  StudentFactory.create_student('def', true, true)
end

Before '@review_season' do
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
end