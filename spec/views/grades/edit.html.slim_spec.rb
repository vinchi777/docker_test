require 'rails_helper'

RSpec.describe "grades/edit", :type => :view do
  before(:each) do
    @grade = assign(:grade, Grade.create!(
      :description => "MyString",
      :points => 1
    ))
  end

  it "renders the edit grade form" do
    render

    assert_select "form[action=?][method=?]", grade_path(@grade), "post" do

      assert_select "input#grade_description[name=?]", "grade[description]"

      assert_select "input#grade_points[name=?]", "grade[points]"
    end
  end
end
