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

Given /there's a student invoice/ do
  @invoice = StudentInvoice.new(package: 'Full Package', amount: 15000, review_season: ReviewSeason.first)
  @student.add_invoice @invoice
  visit student_invoices_path(id: @student.id)
end

When /I remove the invoice/ do
  find("#remove-#{@invoice.id}", visible: false).click
  sleep 0.1
  click_on 'Yes'
end

Then /I should not see the invoice/ do
  expect(page).not_to have_content(@invoice.review_season.season)
end

When /I add a new transaction/ do
  click_on 'Add Transaction'
end

When /I fill up these transaction information/ do |table|
  table.raw.each do |name, value|
    fill_in "transaction[#{name}]", with: value
  end
end

When /I submit the transaction form/ do
  find('input.peso').native.send_keys :return
  sleep 0.3
end

Then /the transaction is added to the invoice/ do
  @invoice = StudentInvoice.find(@invoice.id)
  expect(@invoice.transactions).not_to be_empty
end

Then /I see the balance updated/ do
  expect(page).to have_content 'Balance Php 0.00'
  expect(@invoice.balance).to eq 0
end

And /I press the remove transaction button/ do
  execute_script '$("a.remove-transaction").show()'
  all('a.remove-transaction').first.click
  sleep 0.1
  click_on 'Yes'
end

Then /I should not see the transaction on the invoice/ do
  expect(StudentInvoice.find(@invoice.id).transactions).to be_empty
  expect(page).not_to have_css '.transaction'
end