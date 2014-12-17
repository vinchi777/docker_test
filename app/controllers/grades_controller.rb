class GradesController < AdminController
  before_action :set_grade, only: [:show, :edit, :update, :destroy]
  before_action :set_page

  layout 'grades'
  respond_to :html, :json

  def index
    @review_seasons = ReviewSeason.descending
  end

  def new
    @grade = Grade.new
    if params[:season]
      review_season = ReviewSeason.find(params[:season])
    elsif ReviewSeason.current
      review_season = ReviewSeason.current
      flash[:notice] = 'Since no season is specified, the current review season will be used.'
    else
      flash[:alert] = 'No ongoing season found. Please add a review season that includes this day.'
    end

    if flash[:alert]
      redirect_to grades_path
    else
      @grade.review_season = review_season
      @enrollments = @grade.review_season.enrolled
      review_season.enrolled.each do |e|
        @grade.student_grades << StudentGrade.new(student_enrollment: e)
      end
      respond_with @grade
    end
  end

  def edit
    @enrollments = @grade.review_season.enrolled
  end

  def create
    @grade = Grade.new(grade_params)

    respond_to do |format|
      if @grade.save
        format.html { redirect_to grades_path }
      else
        @enrollments = @grade.review_season.enrolled
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @grade.update(grade_params)
        format.html { redirect_to grades_path }
      else
        @enrollments = @grade.review_season.enrolled
        format.html { render :edit }
      end
    end
  end

  def destroy
    @grade.destroy
    respond_with @grade
  end

  def new_student_grade
    student_grade = StudentGrade.new(student_enrollment: params[:student_enrollment])
    render partial: 'student_strip', locals: {student_grade: student_grade, index: params[:index]}
  end

  private
  def set_grade
    @grade = Grade.find(params[:id])
  end

  def grade_params
    params.require(:grade).permit(:id, :description, :date, :points, :review_season_id, student_grades_attributes: [:id, :score, :student_enrollment_id, :to_delete])
  end

  def set_page
    @page = 'grades'
  end
end
