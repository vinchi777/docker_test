Given /I am on the review seasons page/ do
  visit review_seasons_path
end

Then /I should not see any modal/ do
  expect(all('.modal', count: 0).count).to eq 0
end

Then /the review season is persisted/ do
  expect(ReviewSeason.count).to eq 1
end

Given /I click the update button of a review season/ do
  find("#update-#{@season.id}", match: :first).click
end

When /I remove a review season/ do
  @count = ReviewSeason.count
  find("#remove-#{@season.id}", match: :first).click
  click_on 'Yes'
end

When /I cancel the removal of a review season/ do
  @count = ReviewSeason.count
  find("#remove-#{@season.id}", match: :first).click
  click_on 'No'
end

Then /the review season should be updated/ do
  expect_updated @season.attributes, @season.reload.attributes
end

Then /^I should( not)? see the review season/ do |arg|
  count = @count
  count = 0 if arg
  expect(ReviewSeason.count).to eq count
  expect(all('.review-season', count: count).count).to eq count
end
