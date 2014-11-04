class StudentInvoice
  include Mongoid::Document

  field :package, type: String
  validates_presence_of :package

  field :description, type: String

  field :review_seasons, type: String
  validates_presence_of :review_seasons

  field :amount, type: BigDecimal
  validates_presence_of :amount
  validates :amount, numericality: {greater_than: 0.0}

  field :discount, type: String

  embedded_in :student
  embeds_many :transactions
end


class Transaction
  include Mongoid::Document

  field :date, type: Date
  validates_presence_of :date

  field :or, type: String
  field :method, type: String
  field :amount, type: BigDecimal
  validates_presence_of :amount

  embedded_in :student_invoice
end
