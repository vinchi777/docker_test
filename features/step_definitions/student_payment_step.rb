And /^I add a student invoice$/ do
  visit student_invoices_path(id: @student.id)
  find('.new-invoice.btn').click
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
  find("#invoice-#{@invoice.id}").hover
  find("#remove-#{@invoice.id}").click
  click_on 'Yes'
end

Then /I should not see the invoice/ do
  expect(page).not_to have_content(@invoice.review_season.season)
end

When /I add a new transaction/ do
  find_link('Add Transaction', match: :first).click
end

When /I submit the transaction form/ do
  execute_script "$('.save-transaction').removeClass('hide')"
  find('.save-transaction', match: :first).click
end

Then /the transaction is added to the invoice/ do
  sleep 0.2
  @invoice = StudentInvoice.find(@invoice.id)
  expect(@invoice.transactions).not_to be_empty
end

Then /I see the balance updated/ do
  expect(page).to have_content 'Balance Php 0.00'
  expect(@invoice.balance).to eq 0
end

And /I press the remove transaction button/ do
  find('.transaction', match: :first).hover
  find('a.remove-transaction', match: :first).click
  click_on 'Yes'
end

Then /I should not see the transaction on the invoice/ do
  expect(StudentInvoice.find(@invoice.id).transactions).to be_empty
  expect(page).not_to have_css '.transaction'
end