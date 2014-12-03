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

  has_many :student_invoices, dependent: :restrict
  has_many :enrollments, class_name: 'StudentEnrollment', dependent: :restrict
  has_many :grades, dependent: :destroy

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

  def self.current
    if ReviewSeason.exists?
      ReviewSeason.all.sort_by { |r| r.season_start }.last
    else
      ReviewSeason.new(full_review: 16000, double_review: 22000, coaching: 7000, reservation: 3000)
    end
  end

  has_many :student_invoices, dependent: :restrict

  def get_fee(package)
    if package == 'Coaching'
      coaching
    else
      full_review
    end
  end

  def as_json(opt = nil)
    hash = self.serializable_hash(nil)
    hash[:id] = self.id.to_s
    hash.as_json(nil)
  end

  def to_s
    season
  end

  def students
    enrollments.map { |e| e.student }
  end

  def enrolled_students
    enrolled.map { |e| e.student }
  end

  def enrolling
    enrollments.where(status_cd: 1)
  end

  def enrolled
    enrollments.where(status_cd: 2)
  end

  def self.descending
    ReviewSeason.desc(:season_start)
  end
end
