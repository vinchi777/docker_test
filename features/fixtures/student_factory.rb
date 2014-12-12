class StudentFactory
  def self.create_student(name, create_invoice = false, enroll = false)
    civil_status = Student.civil_statuses.keys
    s = Student.create!(
        first_name: name,
        last_name: 'dela Cruz',
        civil_status: civil_status[rand(civil_status.size)],
        sex: 'Male',
        address: 'Tacloban City',
        contact_no: '321-444',
        email: "#{name}@gmail.com",
        last_attended: 'St. Therese School of Medicine',
        college_year: 2014,
        hs: 'St. Marys Academy',
        hs_year: 2006,
        elem: 'Luntad Elem. School',
        elem_year: 2002
    )
    if create_invoice
      e = s.enrollment_on(ReviewSeason.first)
      @invoice = e.create_invoice(
          package: 'Full Package',
          amount: 15000,
      )
      if enroll
        s.current_enrollment.enroll
      end
    end
    s
  end

  def self.for_searching
    Student.create!(
        first_name: 'John',
        last_name: 'dela Cruz',
        sex: 'Male',
        civil_status: :single,
        address: 'Tacloban City',
        contact_no: '321-444',
        email: 'jdelacruz@gmail.com',
        last_attended: 'Cebu Institute of Medicine',
        college_year: 2014,
        hs: 'St. Marys Academy',
        hs_year: 2006,
        elem: 'Luntad Elem. School',
        elem_year: 2002
    )
    Student.create!(
        first_name: 'Maria',
        last_name: 'dela Cruz',
        sex: 'Male',
        civil_status: :single,
        address: 'Tacloban City',
        contact_no: '321-444',
        email: 'maria@gmail.com',
        last_attended: 'St. Therese School of Medicine',
        college_year: 2014,
        hs: 'St. Marys Academy',
        hs_year: 2006,
        elem: 'Luntad Elem. School',
        elem_year: 2002
    )
  end
end