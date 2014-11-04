class StudentPaymentsController < AdminController
  before_action :set_student_payment, only: [:show, :update, :destroy]

  def index
    @page = 'payment'
    @student = Student.find(params[:id])
    @payment = StudentPayment.new

    respond_to do |format|
      format.html
      format.json { render json: @student.payments }
    end
  end

  def create
    student = Student.find(student_payment_params[:student_id])
    @student_payment = StudentPayment.new(student_payment_params.except :student_id)
    @student_payment.student = student
    respond_to do |format|
      if @student_payment.save
        format.json { render json: @student_payment }
      else
        format.json { render json: @student_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @student_payment.update(student_payment_params)
    respond_with(@student_payment)
  end

  def destroy
    respond_to do |format|
      if @student_payment.destroy
        format.json { head :no_content }
      else
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  private
  def set_student_payment
    @student_payment = Student.find(params[:student_id]).payments.where(id: params[:id])
  end

  def student_payment_params
    params.require(:student_payment).permit(:student_id, :package, :description, :review_seasons, :amount, :discount)
  end
end
