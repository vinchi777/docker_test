class Test
  include Mongoid::Document
  field :description, type: String
  validates_presence_of :description

  field :date, type: Date
  validates_presence_of :date

  field :deadline, type: Time
  validates_presence_of :deadline

  field :timer, type: Integer
  validates_numericality_of :timer, greater_than_or_equal_to: 0, less_than_or_equal_to: 360, only_integer: true

  field :random, type: Boolean

  has_many :questions
  accepts_nested_attributes_for :questions
  validates_associated :questions

  has_many :answer_sheets, dependent: :destroy

  belongs_to :review_season
  validates_presence_of :review_season

  before_validation do |t|
    if t.questions.length == 0
      t.errors[:questions] << 'are required'
    end
  end

  def has_answer_sheet?(student)
    enrollment = student.enrollments.where(review_season: review_season).first
    enrollment && enrollment.answer_sheets.where(test: self).exists?
  end

  def answer_sheet_of(student)
    enrollment = student.enrollments.where(review_season: review_season).first
    enrollment.answer_sheets.find_by(test: self.id) if enrollment
  end

  def create_answer_sheet_for(student)
    enrollment = student.enrollments.where(review_season: review_season).first
    unless has_answer_sheet? student
      a = AnswerSheet.create(student_enrollment: enrollment, test: self)
      qs =
          if random
            questions.shuffle
          else
            questions
          end
      qs.each do |q|
        a.answers.create(id: q.id)
      end
      a.save
    end
  end

  def deadline?
    Time.now > deadline
  end

  def test?
    true
  end

  def timer?
    timer != 0
  end

  def passed
    answer_sheets.count { |s| s.passed? } if deadline?
  end

  def failed
    answer_sheets.length - passed if deadline?
  end

  def passing_rate
    (passed / answer_sheets.length.to_d * 100) if deadline?
  end

  def average
    return 0 if answer_sheets.empty?
    answer_sheets.inject(0) { |sum, s| sum + s.percent } / answer_sheets.size
  end

  def points
    questions.size
  end

  def self.finished
    Test.all.select { |t| t.deadline? }
  end

  def can_copy?
    current = ReviewSeason.current
    if current
      t = Test.where(review_season: current.id, description: description)
      current && review_season != current && t.empty?
    else
      false
    end
  end

  # Copy this test to the current review season
  # @return [ persisted document, nil]
  def copy
    if can_copy?
      current = ReviewSeason.current
      t = Test.create(
          description: description,
          date: Date.today,
          deadline: current.season_end.to_time,
          timer: timer,
          random: random,
          review_season: current,
          questions: questions
      )
      t if t.persisted?
    end
  end
end