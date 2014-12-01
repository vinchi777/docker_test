class AnswerSheetsController < AdminController
  before_action :set_sheet, only: [:show, :edit, :update, :destroy, :submit]

  respond_to :html, :json
  layout 'students', only: [:show]

  def index
    @sheets = AnswerSheet.where(student: params[:student])
    respond_with @sheets
  end

  def show
    @student = @sheet.student
    unless @sheet.started
      @sheet.start_time = Time.now
      @sheet.started = true
      @sheet.save
    end
    respond_with @sheet
  end

  def update
    respond_with @sheet do |format|
      if @sheet.submitted
        format.json { render json: {error: 'already submitted'}, status: :unprocessable_entity }
      else
        if @sheet.update(sheet_params)
          format.json { render :show }
        else
          format.json { render json: @sheet.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @sheet.destroy
    respond_with @sheet
  end

  def submit
    respond_with @sheet do |format|
      if @sheet.test.deadline?
        @sheet.submitted = true
        if @sheet.update
          format.json { render :show }
        else
          format.json { render json: @sheet.errors, status: :unprocessable_entity }
        end
      elsif !@sheet.submitted
        @sheet.assign_attributes(sheet_params)
        @sheet.submitted = true
        if @sheet.update
          format.json { render :show }
        else
          format.json { render json: @sheet.errors, status: :unprocessable_entity }
        end
      else
        format.json { render json: {status: :unprocessable_entity} }
      end
    end
  end

  private
  def set_sheet
    @sheet = AnswerSheet.find(params[:id])
  end

  def sheet_params
    params.require(:answer_sheet).permit(:start_time, :answers, :student, :test, answers: [:id, :index])
  end
end