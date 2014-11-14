And /^I select a student$/ do
  if Student.exists?
    @student = Student.first
  else
  end
  pending # express the regexp above with the code you wish you had
end

When /^I add a student invoice$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I fill up these invoice information$/ do |table|
  pending # express the regexp above with the code you wish you had
end

And /^I submit the invoice form$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the invoice on the student payment form$/ do
  pending # express the regexp above with the code you wish you had
end
