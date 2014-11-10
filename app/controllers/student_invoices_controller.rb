class StudentInvoicesController < AdminController
  before_action :set_student_payment, only: [:show, :update, :destroy, :create_transaction, :destroy_transaction]

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

    if params[:student_invoice][:review_season]
      @student_invoice.review_season = ReviewSeason.find(params[:student_invoice][:review_season][:id])
    end

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

  def create_transaction
    tr = Transaction.new(transaction_params.except :student_id, :id)
    @student_invoice.transactions << tr

    respond_to do |format|
      if @student_invoice.save
        format.json { render json: @student_invoice }
      else
        format.json { render json: tr.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_transaction
    @student_invoice.transactions.find(params[:transaction][:tr_id]).destroy

    respond_to do |format|
      if @student_invoice.save
        format.json { head :no_content }
      else
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  private
  def set_student_payment
    @student_invoice = Student.find(params[:student_id]).invoices.find(params[:id])
  end

  def student_invoice_params
    params.require(:student_invoice).permit(:student_id, :package, :description, :amount, :discount)
  end

  def transaction_params
    params.require(:transaction).permit(:student_id, :id, :tr_id, :date, :or_no, :method, :amount)
  end
end
