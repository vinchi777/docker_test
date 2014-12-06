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

  embeds_many :questions
  accepts_nested_attributes_for :questions
  validates_associated :questions

  has_many :answer_sheets, dependent: :destroy

  belongs_to :review_season
  validates_presence_of :review_season

  def has_answer_sheet?(student)
    enrollment = student.enrollments.where(review_season: review_season).first
    enrollment && enrollment.answer_sheets.where(test: self).exists?
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
end

class Question
  include Mongoid::Document

  field :text, type: String
  validates_presence_of :text

  field :choice1, type: String
  field :choice2, type: String
  field :choice3, type: String
  field :choice4, type: String

  field :answer, type: Integer
  validate :has_answer

  def has_answer
    if answer.nil? || answer < 0 || answer > 3
      errors.add :answer, 'not found'
    end
  end

  field :ratio, type: String

  embedded_in :test
end
