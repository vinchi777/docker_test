class EnrollmentController < ApplicationController
  include Wicked::Wizard

  layout 'enrollment'

  steps :package_type, :personal_information, :education, :other_information, :terms_and_conditions,
        :payment, :confirmation

  def show
    @student = Student.new
    render_wizard
  end
end
