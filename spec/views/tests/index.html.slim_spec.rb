require 'rails_helper'

RSpec.describe "tests/index", :type => :view do
  before(:each) do
    assign(:tests, [
      Test.create!(
        :description => "Description",
        :timer => 1,
        :random => false
      ),
      Test.create!(
        :description => "Description",
        :timer => 1,
        :random => false
      )
    ])
  end

  it "renders a list of tests" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
