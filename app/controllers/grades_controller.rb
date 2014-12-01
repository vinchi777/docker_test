class GradesController < AdminController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]
  before_action :set_page

  layout 'admin'
  respond_to :html, :json

  def index
    @grades = Grade.all
    respond_with @grades
  end

  def show
    respond_with @grade
  end

  def new
    @grade = Grade.new
    @students = ReviewSeason.current.students
    respond_with @grade
  end

  def edit
  end

  def create
    @grade = Grade.new(grade_params)
    @grade.save
    respond_with @grade
  end

  def update
    @grade.update(grade_params)
    respond_with @grade
  end

  def destroy
    @grade.destroy
    respond_with @grade
  end

  def temp_show
    @students = ReviewSeason.current.students
    render 'show'
  end

  def grades_per_season
    @grades = Grade.all.group_by {|g| g.review_season}
    respond_with @grades
  end

  private
  def set_grade
    @grade = Grade.find(params[:id])
  end

  def grade_params
    params.require(:grade).permit(:description, :date, :points, :review_season_id)
  end

  def set_page
    @page = 'grades'
  end
end
