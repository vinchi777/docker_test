When /^I am on the new student page$/ do
  visit new_student_path
end

When /^I fill up these student information/ do |table|
  table.raw.each do |name, value, type|
    case type
      when 'text'
        fill_in name, with: value
      when 'select'
        select value, from: name
    end
  end
end

When /^I submit the student form/ do
  click_on 'save-btn'
end

Then /^I should see (\d+) errors/ do |i|
  expect(all('.error li').count).to eq i.to_i
end

Then /^I should be on the students page$/ do
  expect(current_path).to eq students_path
end
