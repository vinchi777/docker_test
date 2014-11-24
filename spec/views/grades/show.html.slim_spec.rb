require 'rails_helper'

RSpec.describe "grades/show", :type => :view do
  before(:each) do
    @grade = assign(:grade, Grade.create!(
      :description => "Description",
      :points => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/1/)
  end
end
