require 'rails_helper'

RSpec.describe "students/edit", :type => :view do
  before(:each) do
    @student = assign(:student, Student.create!(
      :first_name => "MyString",
      :middle_name => "MyString",
      :last_name => "MyString",
      :sex => "",
      :address => "MyString",
      :contact_no => "MyString",
      :email => "MyString",
      :parent_first_name => "MyString",
      :parent_last_name => "MyString",
      :parent_contact => "MyString",
      :last_attended => "MyString",
      :college_year => "",
      :recognition => "MyString",
      :hs => "MyString",
      :hs_year => "",
      :elem => "MyString",
      :elem_year => "",
      :referrer_first_name => "MyString",
      :referrer_last_name => "MyString",
      :why => "MyText",
      :facebook => "MyString",
      :twitter => "MyString",
      :linkedin => "MyString"
    ))
  end

  it "renders the edit student form" do
    render

    assert_select "form[action=?][method=?]", student_path(@student), "post" do

      assert_select "input#student_firstName[name=?]", "student[firstName]"

      assert_select "input#student_middleName[name=?]", "student[middleName]"

      assert_select "input#student_lastName[name=?]", "student[lastName]"

      assert_select "input#student_sex[name=?]", "student[sex]"

      assert_select "input#student_address[name=?]", "student[address]"

      assert_select "input#student_contactNo[name=?]", "student[contactNo]"

      assert_select "input#student_email[name=?]", "student[email]"

      assert_select "input#student_parentFirstName[name=?]", "student[parentFirstName]"

      assert_select "input#student_parentLastName[name=?]", "student[parentLastName]"

      assert_select "input#student_parentContact[name=?]", "student[parentContact]"

      assert_select "input#student_lastAttended[name=?]", "student[lastAttended]"

      assert_select "input#student_yearGrad[name=?]", "student[yearGrad]"

      assert_select "input#student_recognition[name=?]", "student[recognition]"

      assert_select "input#student_hs[name=?]", "student[hs]"

      assert_select "input#student_hsYear[name=?]", "student[hsYear]"

      assert_select "input#student_elem[name=?]", "student[elem]"

      assert_select "input#student_elemYear[name=?]", "student[elemYear]"

      assert_select "input#student_referrerFirstName[name=?]", "student[referrerFirstName]"

      assert_select "input#student_referrerLastName[name=?]", "student[referrerLastName]"

      assert_select "textarea#student_why[name=?]", "student[why]"

      assert_select "input#student_facebook[name=?]", "student[facebook]"

      assert_select "input#student_twitter[name=?]", "student[twitter]"

      assert_select "input#student_linkedin[name=?]", "student[linkedin]"
    end
  end
end
