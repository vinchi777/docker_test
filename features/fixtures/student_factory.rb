class StudentFactory
  def self.create_student(name, create_invoice = false, enroll = false)
    s = Student.create!(
        first_name: name,
        last_name: 'dela Cruz',
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
      i = StudentInvoice.new(
          package: 'Full Package',
          amount: 15000,
          review_season: ReviewSeason.first
      )
      s.add_invoice i

      if enroll
        s.current_enrollment.enroll
      end
    end
  end
end