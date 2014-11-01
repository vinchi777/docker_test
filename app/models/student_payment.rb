class StudentPayment
  include Mongoid::Document

  field :package, type: String
  validates_presence_of :package

  field :description, type: String

  field :review_seasons, type: String
  validates_presence_of :review_seasons

  field :amount, type: BigDecimal
  validates_presence_of :amount
  validates :amount, numericality: { greater_than: 0.0 }

  field :discount, type: String

  embedded_in :student
end
