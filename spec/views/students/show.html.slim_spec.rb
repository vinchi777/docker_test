require 'rails_helper'

RSpec.describe "students/show", :type => :view do
  before(:each) do
    @student = assign(:student, Student.create!(
      :first_name => "First Name",
      :middle_name => "Middle Name",
      :last_name => "Last Name",
      :sex => "",
      :address => "Address",
      :contact_no => "Contact No",
      :email => "Email",
      :parentFirstName => "Parent First Name",
      :parentLastName => "Parent Last Name",
      :parentContact => "Parent Contact",
      :lastAttended => "Last Attended",
      :yearGrad => "",
      :recognition => "Recognition",
      :hs => "Hs",
      :hsYear => "",
      :elem => "Elem",
      :elemYear => "",
      :referrerFirstName => "Referrer First Name",
      :referrerLastName => "Referrer Last Name",
      :why => "MyText",
      :facebook => "Facebook",
      :twitter => "Twitter",
      :linkedin => "Linkedin"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Middle Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/Contact No/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Parent First Name/)
    expect(rendered).to match(/Parent Last Name/)
    expect(rendered).to match(/Parent Contact/)
    expect(rendered).to match(/Last Attended/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Recognition/)
    expect(rendered).to match(/Hs/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Elem/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Referrer First Name/)
    expect(rendered).to match(/Referrer Last Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Facebook/)
    expect(rendered).to match(/Twitter/)
    expect(rendered).to match(/Linkedin/)
  end
end
