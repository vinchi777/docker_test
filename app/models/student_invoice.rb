class StudentInvoice
  include Mongoid::Document

  field :package, type: String
  validates_presence_of :package

  field :description, type: String

  field :amount, type: BigDecimal
  validates_presence_of :amount
  validates :amount, numericality: {greater_than: 0.0}

  field :discount, type: String

  belongs_to :student
  embeds_many :transactions
  belongs_to :review_season
  validates_presence_of :review_season

  def balance
    amount * discount - transactions.map { |t| t.amount }.sum
  end

  def as_json(opt = nil)
    json = {
        _id: id,
        package: package,
        description: description,
        amount: amount,
        discount: discount,
        transactions: transactions,
    }
    if review_season
      json.merge review_season: {
                     id: review_season.id,
                     season: review_season.season
                 }
    else
      json
    end
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
