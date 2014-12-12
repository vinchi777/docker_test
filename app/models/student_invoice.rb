class StudentInvoice
  include Mongoid::Document

  field :package, type: String
  validates_presence_of :package

  field :description, type: String

  field :amount, type: BigDecimal
  validates_presence_of :amount
  validates :amount, numericality: {greater_than: 0.0}

  field :discount, type: BigDecimal, default: 0

  belongs_to :student_enrollment
  validates_presence_of :student_enrollment

  embeds_many :transactions, after_add: :check_for_confirmation

  def review_season
    student_enrollment.review_season
  end

  def balance
    BigDecimal(amount) * (1 - BigDecimal(discount)) - sum
  end

  def sum
    transactions.map { |t| t.amount }.sum
  end

  def has_balance?
    balance > 0
  end

  def check_for_confirmation(t)
    student_enrollment.check_paid_transactions
  end
end

class Transaction
  include Mongoid::Document

  field :date, type: Date
  validates_presence_of :date

  field :or_no, type: String
  validates_presence_of :or_no

  field :method, type: String
  validates_presence_of :method

  field :amount, type: BigDecimal
  validates_numericality_of :amount, greater_than: 0

  embedded_in :student_invoice
end
