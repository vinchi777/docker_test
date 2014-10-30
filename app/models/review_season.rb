class ReviewSeason
  include Mongoid::Document

  field :start, type: Date
  validates_presence_of :start

  field :end, type: Date
  validates_presence_of :end

  field :promoStart, type: Date
  field :promoEnd, type: Date
  field :repeater, type: BigDecimal

  field :fullReview, type: BigDecimal
  validates_presence_of :fullReview

  field :doubleReview, type: BigDecimal
  validates_presence_of :doubleReview

  field :coaching, type: BigDecimal
  validates_presence_of :coaching

  field :reservation, type: BigDecimal
  validates_presence_of :reservation
end
