require 'rails_helper'

RSpec.describe "student_payments/index", :type => :view do
  before(:each) do
    assign(:student_payments, [
      StudentPayment.create!(
        :description => "Description",
        :reviewSeasons => "Review Seasons",
        :amount => "",
        :discount => "Discount"
      ),
      StudentPayment.create!(
        :description => "Description",
        :reviewSeasons => "Review Seasons",
        :amount => "",
        :discount => "Discount"
      )
    ])
  end

  it "renders a list of student_payments" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Review Seasons".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Discount".to_s, :count => 2
  end
end
