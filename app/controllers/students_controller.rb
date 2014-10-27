class StudentsController < AdminController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    # @students = Student.all
    @students = [{
                     firstName: 'Maria Divina',
                     middleInitial: 'D.',
                     lastName: 'Acala',
                     school: 'St. Scholasticas College',
                     address: 'District 4, Burauen, Leyte',
                     status: {
                         name: 'Enrolled',
                         season: 'April 2014'
                     },
                     balance: 13000
                 }]
  end

  def show
    respond_with(@student)
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @student = Student.new(student_params)
    @student.save
    respond_with(@student)
  end

  def update
    @student.update(student_params)
    respond_with(@student)
  end

  def destroy
    @student.destroy
    respond_with(@student)
  end

  private
  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:firstName, :middleName, :lastName, :birthdate, :sex, :address, :contactNo, :email, :parentFirstName, :parentLastName, :parentContact, :lastAttended, :yearGrad, :recognition, :hs, :hsYear, :elem, :elemYear, :referrerFirstName, :referrerLastName, :why, :facebook, :twitter, :linkedin)
  end
end
