class StudentsController < AdminController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :confirm]

  def index
    q = params[:q]
    page = params[:page]
    season = params[:season]
    status = params[:status]

    respond_to do |format|
      format.html { render :index }
      format.json do
        if q.nil? || q.blank?
          students = Student.filter(season, status)
          @students = students.asc('lastName', 'firstName').paginate(page: page, per_page: 10)
          size = students.length
        else
          r = Student.filter(season, status).or({lastName: /#{q}/i}, {firstName: /#{q}/i}, {address: /#{q}/i}, {lastAttended: /#{q}/i}).asc('lastName', 'firstName')
          @students = r.paginate(page: page, per_page: 10)
          size = r.length
        end
        render json: {students: @students, totalSize: size}
      end
    end
  end

  def show
    @student.as_json
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
    @student.enrollment_process=0

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
    @student.enrollment_process=0

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
    render json: StudentEnrollment.status_json
  end

  private
  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:firstName, :middleName, :lastName, :birthdate, :sex, :address, :contactNo, :email, :parentFirstName, :parentLastName, :parentContact, :lastAttended, :yearGrad, :recognition, :hs, :hsYear, :elem, :elemYear, :referrerFirstName, :referrerLastName, :referrerContact, :why, :facebook, :twitter, :linkedin)
  end
end
