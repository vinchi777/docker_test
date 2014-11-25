Then /^I should see "(.*?)"$/ do |text|
  expect(page).to have_content text
end

When /^I press the "(.*?)" button$/ do |label|
  click_on label
end

Then /^I should be on the homepage$/ do
  expect(current_path).to eq root_path
end