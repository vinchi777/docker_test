class GradesController < AdminController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]
  before_action :set_page

  layout 'grades'
  respond_to :html, :json

  def index
    @review_seasons = ReviewSeason.descending
    @grades = Grade.all
    respond_with @grades
  end

  def show
    respond_with @grade
  end

  def new
    @grade = Grade.new
    @grade.review_season = ReviewSeason.find(params[:season])
    ReviewSeason.current.enrolled.each do |e|
      @grade.student_grades << StudentGrade.new(student_enrollment: e)
    end
    respond_with @grade
  end

  def edit
  end

  def create
    @grade = Grade.new(grade_params)
    @grade.review_season = ReviewSeason.current

    respond_to do |format|
      if @grade.save
        format.html { redirect_to grades_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @grade.update(grade_params)
        format.html { redirect_to grades_path }
      else
        format.html { render :edit }
      end
    end
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
    @grades = Grade.all.group_by { |g| g.review_season }
    respond_with @grades
  end

  private
  def set_grade
    @grade = Grade.find(params[:id])
  end

  def grade_params
    params.require(:grade).permit(:description, :date, :points, :review_season_id, student_grades_attributes: [:id, :score, :student_enrollment_id])
  end

  def set_page
    @page = 'grades'
  end
end
