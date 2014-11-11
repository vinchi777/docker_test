class StudentsController < AdminController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :confirm]

  def index
    q = params[:q]

    @students =
        if q.nil?
          Student.all.paginate(page: params[:page], per_page: 10)
        else
          Student.where(lastName: /#{q}/i).paginate(page: params[:page], per_page: 10)
          # search(q).paginate(page: params[:page], per_page: 10)
        end

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @students }
    end
  end

  def search(q)
    a = Student.where(lastName: /#{q}/i).to_set
    b = Student.where(firstName: /#{q}/i).to_set
    c = Student.where(lastAttended: /#{q}/i).to_set
    d = Student.where(address: /#{q}/i).to_set
    res = a | b | c | d
    res.nil? ? [] : res
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
    respond_to do |format|
      if @student.save
        format.html { redirect_to students_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to students_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @student.destroy
        format.json { head :no_content }
      else
        format.json { render status: :unprocessable_entity }
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

  private
  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:firstName, :middleName, :lastName, :birthdate, :sex, :address, :contactNo, :email, :parentFirstName, :parentLastName, :parentContact, :lastAttended, :yearGrad, :recognition, :hs, :hsYear, :elem, :elemYear, :referrerFirstName, :referrerLastName, :referrerContact, :why, :facebook, :twitter, :linkedin)
  end
end
