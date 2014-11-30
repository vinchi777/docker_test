require 'rails_helper'

RSpec.describe "tests/show", :type => :view do
  before(:each) do
    @test = assign(:test, Test.create!(
      :description => "Description",
      :timer => 1,
      :random => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
  end
end
