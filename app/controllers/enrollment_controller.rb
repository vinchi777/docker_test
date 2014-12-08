class EnrollmentController < ApplicationController
  include Wicked::Wizard

  layout 'enrollment'

  steps :package_type, :personal_information, :education, :other_information, :terms_and_conditions,
        :payment, :confirmation

  before_action :set_student, only: [:show]
  before_action :set_student_2, only: [:update]
  before_action :set_season
  before_action :update_enrollment_status, only: [:show]

  def show
    @page = 'enrollment'
    if step == :personal_information && !%w{Standard Double Coaching}.include?(params[:package_type])
      redirect_to previous_wizard_path, flash: {error: 'Package type is invalid.'}
    else
      @season = ReviewSeason.current if (step == :terms_and_conditions || step == :payment) && ReviewSeason.exists?
      render_wizard
    end
  end

  def update
    @page = 'enrollment'
    if process_step
      if @student
        redirect_to next_wizard_path(:student_id => @student.id)
      elsif @type
        redirect_to next_wizard_path(package_type: @type)
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
  def process_step
    if step == :package_type
      @type = params[:package_type]
      @type.present?
    elsif step ==:personal_information
      @student.save_profile_pic params[:student][:profile_pic], params[:student][:clean]
      @student.save
    elsif step == :terms_and_conditions
      @student.update_attributes({agreed: true})
      @student.setup_payment
    elsif step == :payment
      @student.finish_enrollment_process
    else
      @student.update_attributes student_params
    end
  end

  def set_season
    @season = ReviewSeason.current
  end

  def set_student
    if params[:student_id]
      @student = Student.find(params[:student_id])
    else
      @student = Student.new({enrollment_process: step_index_for(step), package_type: params[:package_type]})
    end
  end

  def set_student_2
    return if step == :package_type
    if params[:student_id]
      @student = Student.find(params[:student_id])
    else
      @student = Student.new student_params
    end
  end

  def student_params
    params.require(:student).permit(:firstName, :middleName, :lastName, :birthdate, :sex, :address, :contactNo, :email,
                                    :parentFirstName, :parentLastName, :parentContact, :lastAttended, :yearGrad,
                                    :recognition, :hs, :hsYear, :elem, :elemYear, :referrerFirstName, :referrerLastName,
                                    :why, :facebook, :twitter, :linkedin, :enrollment_process, :package_type)
  end

  def update_enrollment_status
    @student.enrollment_process = step_index_for step
  end
end
