class AnswerSheetsController < AdminController
  before_action :set_sheet, only: [:show, :edit, :update, :destroy, :submit]

  respond_to :html, :json
  layout 'students', only: [:show]

  def index
    if params[:student]
      @sheets = Student.accessible_by(current_ability).find(params[:student]).enrollments.map { |e| e.answer_sheets }.flatten
      @sheets = @sheets.select do |s|
        set_submission s
        !s.deadline?
      end
      respond_with @sheets
    else
      redirect_to root_path
    end
  end

  def show
    @student = @sheet.student_enrollment.student
    unless @sheet.started? || @sheet.deadline?
      @sheet.start
      @sheet.save
    end
    set_submission @sheet
    respond_with @sheet
  end

  def update
    set_submission @sheet
    respond_with @sheet do |format|
      if @sheet.submitted?
        format.json { render :show }
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
        @sheet.submit
        if @sheet.update
          format.json { render :show }
        else
          format.json { render json: @sheet.errors, status: :unprocessable_entity }
        end
      elsif !@sheet.submitted?
        @sheet.assign_attributes(sheet_params)
        @sheet.submit
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
  def set_submission(sheet)
    unless sheet.submitted? || !(sheet.deadline? || sheet.expired?)
      sheet.submit
      sheet.save
    end
  end

  def set_sheet
    @sheet = AnswerSheet.find(params[:id])
  end

  def sheet_params
    params.require(:answer_sheet).permit(:answers, :student, :test, answers: [:id, :index])
  end
end
