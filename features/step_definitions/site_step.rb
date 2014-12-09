When /^I click the people dropdown$/ do
  find('.toggle-people').click
end

When /^I click the "(.*?)" link$/ do |link|
  click_link link
end

Then /^I should see (\d+) students in our students page$/ do|count|
  expect(all('#our-students .student').count).to eq count
end