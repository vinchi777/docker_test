class StudentsController < AdminController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :confirm, :grades_tests]
  layout 'tests'

  respond_to :json, only: [:enrollment_status]

  def index
    q = params[:q]
    page = params[:page]
    season = params[:season]
    status = params[:status]

    # per_page = 0 means no pagination
    if params[:per_page]
      per_page = params[:per_page]
    else
      per_page = 10
    end

    respond_to do |format|
      format.html { render :index }
      format.json do
        if q.nil? || q.blank?
          students = Student.filter(season, status)
          @students = students.desc('is_enrolling').asc('lastName', 'firstName').paginate(page: page, per_page: per_page)
          @size = students.length
        else
          r = Student.filter(season, status).or({lastName: /#{q}/i}, {firstName: /#{q}/i}, {address: /#{q}/i}, {lastAttended: /#{q}/i}).desc('is_enrolling').asc('lastName', 'firstName')
          @students = r.paginate(page: page, per_page: per_page)
          @size = r.length
        end
        render :index
      end
    end
  end

  def show
    @page = 'show'
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: @student }
    end
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    @student.save_profile_pic params[:student][:profile_pic], params[:student][:clean]
    @student.enrollment_process = 0

    respond_to do |format|
      if @student.save
        format.html { redirect_to students_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @student.save_profile_pic params[:student][:profile_pic], params[:student][:clean]
    @student.enrollment_process = 0

    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to students_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    msg = 'Cannot delete student.'
    respond_to do |format|
      if @student.destroy
        format.json { head :no_content }
      else
        format.json { render json: {message: msg}, status: :unprocessable_entity }
      end
    end
  end

  def grades_tests
    @page = 'grades_and_tests'
  end

  def confirm
    if @student.enrolling?
      @student.current_enrollment.enroll
    end

    respond_to do |format|
      if @student.current_enrollment.save
        format.json { render json: {enrollment_status: @student.enrollment_status} }
      else
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  def enrollment_status
    @statuses = StudentEnrollment.statuses
    respond_with @statuses
  end

  private
  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:firstName, :middleName, :lastName, :birthdate, :sex, :address, :contactNo, :email, :parentFirstName, :parentLastName, :parentContact, :lastAttended, :yearGrad, :recognition, :hs, :hsYear, :elem, :elemYear, :referrerFirstName, :referrerLastName, :referrerContact, :why, :facebook, :twitter, :linkedin)
  end
end
