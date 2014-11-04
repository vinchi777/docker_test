class StudentInvoicesController < AdminController
  before_action :set_student_payment, only: [:show, :update, :destroy]

  def index
    @page = 'payment'
    @student = Student.find(params[:id])
    @payment = StudentInvoice.new

    respond_to do |format|
      format.html
      format.json { render json: @student.invoices }
    end
  end

  def create
    student = Student.find(student_invoice_params[:student_id])
    @student_invoice = StudentInvoice.new(student_invoice_params.except :student_id)
    @student_invoice.student = student
    respond_to do |format|
      if @student_invoice.save
        format.json { render json: @student_invoice }
      else
        format.json { render json: @student_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @student_invoice.update(student_invoice_params)
    respond_with(@student_invoice)
  end

  def destroy
    respond_to do |format|
      if @student_invoice.destroy
        format.json { head :no_content }
      else
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  private
  def set_student_payment
    @student_invoice = Student.find(params[:student_id]).invoices.where(id: params[:id])
  end

  def student_invoice_params
    params.require(:student_invoice).permit(:student_id, :package, :description, :review_seasons, :amount, :discount)
  end
end
