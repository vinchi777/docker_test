require 'rails_helper'

RSpec.describe "student_payments/new", :type => :view do
  before(:each) do
    assign(:student_invoice, StudentInvoice.new(
      :description => "MyString",
      :reviewSeasons => "MyString",
      :amount => "",
      :discount => "MyString"
    ))
  end

  it "renders new student_payment form" do
    render

    assert_select "form[action=?][method=?]", student_payments_path, "post" do

      assert_select "input#student_payment_description[name=?]", "student_payment[description]"

      assert_select "input#student_payment_reviewSeasons[name=?]", "student_payment[reviewSeasons]"

      assert_select "input#student_payment_amount[name=?]", "student_payment[amount]"

      assert_select "input#student_payment_discount[name=?]", "student_payment[discount]"
    end
  end
end
