require 'rails_helper'

RSpec.describe "review_seasons/index", :type => :view do
  before(:each) do
    assign(:review_seasons, [
      ReviewSeason.create!(
        :repeater => "",
        :fullReview => "",
        :doubleReview => "",
        :coaching => "",
        :reservation => ""
      ),
      ReviewSeason.create!(
        :repeater => "",
        :fullReview => "",
        :doubleReview => "",
        :coaching => "",
        :reservation => ""
      )
    ])
  end

  it "renders a list of review_seasons" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
