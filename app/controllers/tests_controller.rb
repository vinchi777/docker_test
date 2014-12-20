class TestsController < AdminController
  before_action :set_test, only: [:show, :update, :destroy, :results, :copy]

  layout 'tests'
  respond_to :html, :json

  def index
    @tests = Test.all
    @tests = @tests.select { |t| !t.deadline? } if params[:status] == 'ongoing'
    respond_with @tests
  end

  def show
    respond_with @test
  end

  def new
    @test = Test.new
    respond_with @test
  end

  def create
    if ReviewSeason.current
      @test = Test.new(test_params)
      @test.review_season = ReviewSeason.current
      @test.questions = questions_from_param
      respond_with @test do |format|
        if @test.save
          format.json { render :show }
        else
          format.json { render json: @test.errors, status: :unprocessable_entity }
        end
      end
    else
      render json: {review_season: ['not found. Please add a review season.']}, status: :unprocessable_entity
    end
  end

  def update
    @test.assign_attributes(test_params)
    @test.questions.clear
    @test.questions = questions_from_param
    respond_with @test do |format|
      if @test.save
        format.json { render :show }
      else
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @test.destroy
    respond_with @test
  end

  def publish
    test = Test.find(params[:id])
    if test
      Student.find(params[:students]).map do |s|
        test.create_answer_sheet_for(s)
      end
      render json: {status: :ok}
    else
      render json: {status: :unprocessable_entity}
    end
  end

  def answer
    render 'show'
  end

  def results
    @students = @test.answer_sheets.map { |a| a.student }
  end

  def copy
    t = @test.copy
    if t
      @test = t
      render :show
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private
  def set_test
    @test = Test.find(params[:id])
  end

  def questions_from_param
    if question_params[:questions]
      question_params[:questions].map do |q_param|
        if q_param[:id]
          qs = Question.where(id: q_param[:id])
          if qs.exists?
            first = qs.first
            first.update(q_param)
            first
          else
            Question.create(q_param.except(:id))
          end
        else
          Question.create(q_param.except(:id))
        end
      end
    else
      []
    end
  end

  def test_params
    params.require(:test).permit(:description, :date, :deadline, :timer, :random)
  end

  def question_params
    params.require(:test).permit(questions: [:id, :text, :choice1, :choice2, :choice3, :choice4, :answer, :ratio])
  end
end
