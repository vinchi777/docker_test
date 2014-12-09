require 'rails_helper'

RSpec.describe "students/index", :type => :view do
  before(:each) do
    assign(:students, [
      Student.create!(
        :first_name => "First Name",
        :middle_name => "Middle Name",
        :last_name => "Last Name",
        :sex => "",
        :address => "Address",
        :contact_no => "Contact No",
        :email => "Email",
        :parent_first_name => "Parent First Name",
        :parent_last_name => "Parent Last Name",
        :parent_contact => "Parent Contact",
        :last_attended => "Last Attended",
        :college_year => "",
        :recognition => "Recognition",
        :hs => "Hs",
        :hs_year => "",
        :elem => "Elem",
        :elem_year => "",
        :referrer_first_name => "Referrer First Name",
        :referrer_last_name => "Referrer Last Name",
        :why => "MyText",
        :facebook => "Facebook",
        :twitter => "Twitter",
        :linkedin => "Linkedin"
      ),
      Student.create!(
        :first_name => "First Name",
        :middle_name => "Middle Name",
        :last_name => "Last Name",
        :sex => "",
        :address => "Address",
        :contact_no => "Contact No",
        :email => "Email",
        :parent_first_name => "Parent First Name",
        :parent_last_name => "Parent Last Name",
        :parent_contact => "Parent Contact",
        :last_attended => "Last Attended",
        :college_year => "",
        :recognition => "Recognition",
        :hs => "Hs",
        :hs_year => "",
        :elem => "Elem",
        :elem_year => "",
        :referrer_first_name => "Referrer First Name",
        :referrer_last_name => "Referrer Last Name",
        :why => "MyText",
        :facebook => "Facebook",
        :twitter => "Twitter",
        :linkedin => "Linkedin"
      )
    ])
  end

  it "renders a list of students" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Middle Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Contact No".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Parent First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Parent Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Parent Contact".to_s, :count => 2
    assert_select "tr>td", :text => "Last Attended".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Recognition".to_s, :count => 2
    assert_select "tr>td", :text => "Hs".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Elem".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Referrer First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Referrer Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Facebook".to_s, :count => 2
    assert_select "tr>td", :text => "Twitter".to_s, :count => 2
    assert_select "tr>td", :text => "Linkedin".to_s, :count => 2
  end
end
