class TestsController < AdminController
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  layout 'tests'
  respond_to :html, :json

  def index
    @tests = Test.all
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
    @test = Test.new(test_params)
    respond_with @test do |format|
      if @test.save
        format.json { render :show }
      else
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_with @test do |format|
      if @test.update(test_params)
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

  private
  def set_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:description, :date, :deadline, :timer, :random, questions: [:id, :text, :choice1, :choice2, :choice3, :choice4, :answer, :ratio])
  end
end
