class ReviewSeason
  include Mongoid::Document

  field :season, type: String
  validates_presence_of :season
  validates_length_of :season, minimum: 3
  validates_uniqueness_of :season

  field :season_start, type: Date
  validates_presence_of :season_start

  field :season_end, type: Date
  validates_presence_of :season_end

  field :promo_start, type: Date
  field :promo_end, type: Date

  field :first_timer, type: BigDecimal
  validates_numericality_of :first_timer, less_than: 1000000, message: 'must be less than 999,999.00'

  field :repeater, type: BigDecimal
  validates_numericality_of :repeater, less_than: 1000000, message: 'must be less than 999,999.00'

  field :full_review, type: BigDecimal
  validates_presence_of :full_review
  validates_numericality_of :full_review, less_than: 1000000, message: 'must be less than 999,999.00'

  field :double_review, type: BigDecimal
  validates_presence_of :double_review
  validates_numericality_of :double_review, less_than: 1000000, message: 'must be less than 999,999.00'

  field :coaching, type: BigDecimal
  validates_presence_of :coaching
  validates_numericality_of :coaching, less_than: 1000000, message: 'must be less than 999,999.00'

  field :reservation, type: BigDecimal
  validates_presence_of :reservation
  validates_numericality_of :reservation, less_than: 1000000, message: 'must be less than 999,999.00'

  validate :date_precedence

  def date_precedence

    if season_start.present? && season_end.present? && season_start + 1.day > season_end
      errors[:season_end] << 'must be after the start of the season'
    end

    if promo_start.blank? && promo_end.present?
      errors[:promo_start] << 'must be defined'
    end

    if promo_start.present? && promo_end.blank?
      errors[:promo_end] << 'must be defined'
    end

    if promo_start.present? && promo_end.present? && promo_start > promo_end
      errors[:promo_end] << 'must be after the start of the promo'
    end
  end

  has_many :student_invoices, dependent: :restrict
end
