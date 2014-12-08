Given /I am on the review seasons page/ do
  visit review_seasons_path
end

Then /I should not see any modal/ do
  expect(all('.modal', count: 0).count).to eq 0
end

Then /the review season is persisted/ do
  expect(ReviewSeason.count).to eq 1
end