When /^I click the people dropdown$/ do
  find('.toggle-people').click
end

When /^I click the "(.*?)" link$/ do |link|
  click_link link
end

Then /^I should see (\d+) students in our students page$/ do |count|
  expect(all('#our-students .student').count).to eq count.to_d
end

Then /^I should see the following founders$/ do |data|
  founders = all('.list > div')
  data.rows.each_with_index do |row, i|
    expect(founders[i].find('h5').text).to eq row[0]
    expect(founders[i].find('.type').text).to eq row[1]
  end
end