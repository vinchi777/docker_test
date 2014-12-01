Given /^I select a student$/ do
  if Student.exists?
    @student = Student.first
  else
    @student = Student.create(
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
  end
  @student.save

  ReviewSeason.create!(
      season: 'May 2014',
      first_timer: 0,
      repeater: 0,
      season_start: 'Apr. 1, 2014',
      season_end: 'Apr. 10, 2014',
      full_review: 17000,
      double_review: 22000,
      coaching: 7000,
      reservation: 3000
  )
  visit student_path(@student)
end

And /^I add a student invoice$/ do
  visit student_invoices_path(id: @student.id)
  find('.new-invoice.btn').click
end

When /^I fill up these invoice information$/ do |table|
  table.raw.each do |name, value, type|
    case type
      when 'text'
        fill_in "invoice[#{name}]", with: value
      when 'select'
        select value, from: "invoice[#{name}]"
    end
  end
end

And /^I submit the invoice form$/ do
  click_on 'Add Invoice'
end

Then /^I should see these invoice information on the student invoice form$/ do |table|
  sleep 0.5
  expect(all('.modal').count).to eq 0
  table.raw.each do |text|
    expect(page).to have_content text[0]
  end
end
