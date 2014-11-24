require 'rails_helper'

RSpec.describe "grades/new", :type => :view do
  before(:each) do
    assign(:grade, Grade.new(
      :description => "MyString",
      :points => 1
    ))
  end

  it "renders new grade form" do
    render

    assert_select "form[action=?][method=?]", grades_path, "post" do

      assert_select "input#grade_description[name=?]", "grade[description]"

      assert_select "input#grade_points[name=?]", "grade[points]"
    end
  end
end
