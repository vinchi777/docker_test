class StudentsController < AdminController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :payment]

  def index
    @students = Student.all
  end

  def show
    respond_to do |format|
      format.html { render :edit }
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
    @student.destroy
    respond_with(@student)
  end

  def payment

  end

  private
  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:firstName, :middleName, :lastName, :birthdate, :sex, :address, :contactNo, :email, :parentFirstName, :parentLastName, :parentContact, :lastAttended, :yearGrad, :recognition, :hs, :hsYear, :elem, :elemYear, :referrerFirstName, :referrerLastName, :why, :facebook, :twitter, :linkedin)
  end
end
