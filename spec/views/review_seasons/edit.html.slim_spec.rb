require 'rails_helper'

RSpec.describe "review_seasons/edit", :type => :view do
  before(:each) do
    @review_season = assign(:review_season, ReviewSeason.create!(
      :repeater => "",
      :fullReview => "",
      :doubleReview => "",
      :coaching => "",
      :reservation => ""
    ))
  end

  it "renders the edit review_season form" do
    render

    assert_select "form[action=?][method=?]", review_season_path(@review_season), "post" do

      assert_select "input#review_season_repeater[name=?]", "review_season[repeater]"

      assert_select "input#review_season_fullReview[name=?]", "review_season[fullReview]"

      assert_select "input#review_season_doubleReview[name=?]", "review_season[doubleReview]"

      assert_select "input#review_season_coaching[name=?]", "review_season[coaching]"

      assert_select "input#review_season_reservation[name=?]", "review_season[reservation]"
    end
  end
end
