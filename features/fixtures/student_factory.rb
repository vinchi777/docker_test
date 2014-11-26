class StudentFactory
  def self.create_student(name, create_invoice = false, enroll = false)
    s = Student.create!(
        firstName: name,
        lastName: 'dela Cruz',
        sex: 'Male',
        address: 'Tacloban City',
        contactNo: '321-444',
        email: "#{name}@gmail.com",
        lastAttended: 'St. Therese School of Medicine',
        yearGrad: 2014,
        hs: 'St. Marys Academy',
        hsYear: 2006,
        elem: 'Luntad Elem. School',
        elemYear: 2002
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