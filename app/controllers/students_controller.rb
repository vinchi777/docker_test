class StudentsController < AdminController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    q = params[:q]

    if q.nil?
      @students = Student.all
    else
      search(q)
    end
  end

  def search(q)
    a = Student.where(lastName: /#{q}/i).to_set
    b = Student.where(firstName: /#{q}/i).to_set
    c = Student.where(lastAttended: /#{q}/i).to_set
    d = Student.where(address: /#{q}/i).to_set
    res = a | b | c | d
    @students = res.nil? ? [] : res
  end

  def show
    @page = 'show'
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
    respond_to do |format|
      if @student.destroy
        format.json { head :no_content }
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
    params.require(:student).permit(:firstName, :middleName, :lastName, :birthdate, :sex, :address, :contactNo, :email, :parentFirstName, :parentLastName, :parentContact, :lastAttended, :yearGrad, :recognition, :hs, :hsYear, :elem, :elemYear, :referrerFirstName, :referrerLastName, :why, :facebook, :twitter, :linkedin)
  end
end
