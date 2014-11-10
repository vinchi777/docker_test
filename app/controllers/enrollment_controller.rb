class EnrollmentController < ApplicationController
  include Wicked::Wizard

  layout 'enrollment'

  steps :package_type, :personal_information, :education, :other_information, :terms_and_conditions,
        :payment, :confirmation

  def show
    case step
      when :package_type
        set_season
      when :personal_information
        @student = Student.new({enrollment_status: step, package_type: params[:package_type]})
      when :payment
        set_season
        update_enrollment_status
      else
        update_enrollment_status
    end

    render_wizard
  end

  def update
    success = true
    case step
      when :package_type
        type = params[:package_type]
        set_season
        success = false unless type
      when :personal_information
        @student = Student.new student_params
        success = @student.save
      when :terms_and_conditions
        set_student
        @student.update_attributes({agreed: true})
        success = @student.setup_payment
      when :payment
        set_student
        @student.finish_enrollment_process
      else
        set_student
        success = @student.update_attributes student_params
    end

    if success
      if @student
        redirect_to next_wizard_path(:student_id => @student.id)
      elsif type
        redirect_to next_wizard_path(package_type: type)
      else
        redirect_to next_wizard_path
      end
    else
      if @student
        render_wizard @student
      else
        render_wizard
      end
    end
  end

  private
  def set_season
    @season = ReviewSeason.current
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  def student_params
    params.require(:student).permit(:firstName, :middleName, :lastName, :birthdate, :sex, :address, :contactNo, :email, :parentFirstName, :parentLastName, :parentContact, :lastAttended, :yearGrad, :recognition, :hs, :hsYear, :elem, :elemYear, :referrerFirstName, :referrerLastName, :why, :facebook, :twitter, :linkedin, :enrollment_status, :package_type)
  end

  def update_enrollment_status
    set_student
    @student.enrollment_status = step
  end
end
