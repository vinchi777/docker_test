require 'rails_helper'

RSpec.describe "review_seasons/new", :type => :view do
  before(:each) do
    assign(:review_season, ReviewSeason.new(
      :repeater => "",
      :fullReview => "",
      :doubleReview => "",
      :coaching => "",
      :reservation => ""
    ))
  end

  it "renders new review_season form" do
    render

    assert_select "form[action=?][method=?]", review_seasons_path, "post" do

      assert_select "input#review_season_repeater[name=?]", "review_season[repeater]"

      assert_select "input#review_season_fullReview[name=?]", "review_season[fullReview]"

      assert_select "input#review_season_doubleReview[name=?]", "review_season[doubleReview]"

      assert_select "input#review_season_coaching[name=?]", "review_season[coaching]"

      assert_select "input#review_season_reservation[name=?]", "review_season[reservation]"
    end
  end
end
