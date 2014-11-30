require 'rails_helper'

RSpec.describe "review_seasons/show", :type => :view do
  before(:each) do
    @review_season = assign(:review_season, ReviewSeason.create!(
      :repeater => "",
      :fullReview => "",
      :doubleReview => "",
      :coaching => "",
      :reservation => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
