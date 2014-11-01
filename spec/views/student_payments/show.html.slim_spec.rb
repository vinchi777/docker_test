require 'rails_helper'

RSpec.describe "student_payments/show", :type => :view do
  before(:each) do
    @student_payment = assign(:student_payment, StudentPayment.create!(
      :description => "Description",
      :reviewSeasons => "Review Seasons",
      :amount => "",
      :discount => "Discount"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Review Seasons/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Discount/)
  end
end
