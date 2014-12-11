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
  sleep 0.5
  @season.reload
  expect(@season.season).to eq @params[:season]
  expect(@season.season_start).to eq DateTime.parse(@params[:season_start])
  expect(@season.season_end).to eq DateTime.parse(@params[:season_end])
  expect(@season.promo_start).to eq DateTime.parse(@params[:promo_start]) if @params[:promo_start]
  expect(@season.promo_end).to eq DateTime.parse(@params[:promo_end]) if @params[:promo_end]
  expect(@season.full_review).to eq BigDecimal('7000')
  expect(@season.double_review).to eq BigDecimal('11000')
  expect(@season.coaching).to eq BigDecimal('5000')
  expect(@season.reservation).to eq BigDecimal('2000')
end

Then /^I should( not)? see the review season/ do |arg|
  count = @count
  count = 0 if arg
  expect(ReviewSeason.count).to eq count
  expect(all('.review-season', count: count).count).to eq count
end
