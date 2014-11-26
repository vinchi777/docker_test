require 'rails_helper'

RSpec.describe "tests/edit", :type => :view do
  before(:each) do
    @test = assign(:test, Test.create!(
      :description => "MyString",
      :timer => 1,
      :random => false
    ))
  end

  it "renders the edit test form" do
    render

    assert_select "form[action=?][method=?]", test_path(@test), "post" do

      assert_select "input#test_description[name=?]", "test[description]"

      assert_select "input#test_timer[name=?]", "test[timer]"

      assert_select "input#test_random[name=?]", "test[random]"
    end
  end
end
