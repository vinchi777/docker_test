class StudentInvoicesController < AdminController
  before_action :set_student_payment, only: [:show, :update, :destroy, :create_transaction, :destroy_transaction]

  layout 'students'
  respond_to :html, :json

  def index
    @page = 'payment'
    @student = Student.find(params[:id])
    @invoices = @student.invoices
    respond_with @invoices
  end

  def create
    unless params[:student_invoice][:review_season]
      render json: {status: :unprocessable_entity}
    end

    student = Student.find(params[:student_invoice][:student_id])
    season = ReviewSeason.find(params[:student_invoice][:review_season][:id])
    e = student.enrollment_on(season)
    @invoice = e.create_invoice(student_invoice_params)

    respond_to do |format|
      if @invoice.save
        format.json { render :show }
      else
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @invoice.update(student_invoice_params)
    respond_with @invoice do |format|
      format.json { render :show }
    end
  end

  def destroy
    respond_to do |format|
      if @invoice.destroy
        format.json { head :no_content }
      else
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  def create_transaction
    tr = Transaction.new(transaction_params.except :student_id, :id)
    @invoice.transactions << tr

    respond_to do |format|
      if @invoice.save
        format.json { render :show }
      else
        format.json { render json: tr.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_transaction
    @invoice.transactions.find(params[:transaction][:tr_id]).destroy

    respond_to do |format|
      if @invoice.save
        format.json { head :no_content }
      else
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  private
  def set_student_payment
    @invoice = StudentInvoice.find(params[:id])
  end

  def student_invoice_params
    params.require(:student_invoice).permit(:package, :description, :amount, :discount)
  end

  def transaction_params
    params.require(:transaction).permit(:student_id, :id, :tr_id, :date, :or_no, :method, :amount)
  end

end
