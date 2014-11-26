require 'rails_helper'

RSpec.describe "tests/new", :type => :view do
  before(:each) do
    assign(:test, Test.new(
      :description => "MyString",
      :timer => 1,
      :random => false
    ))
  end

  it "renders new test form" do
    render

    assert_select "form[action=?][method=?]", tests_path, "post" do

      assert_select "input#test_description[name=?]", "test[description]"

      assert_select "input#test_timer[name=?]", "test[timer]"

      assert_select "input#test_random[name=?]", "test[random]"
    end
  end
end
