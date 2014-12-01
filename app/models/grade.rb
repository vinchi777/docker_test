class Grade
  include Mongoid::Document
  field :description, type: String
  field :date, type: Date
  field :points, type: Integer
  field :average, type: Integer, default: 0

  belongs_to :review_season
  has_many :student_grades, dependent: :destroy
  accepts_nested_attributes_for :student_grades

  validates_presence_of :description
  validates_presence_of :date
  validates_presence_of :points

  before_save :calculate_average

  def test?
    false
  end

  def timer?
    test?
  end

  def calculate_average
    ave = student_grades.inject(0) { |sum, grade| sum + grade.score } / student_grades.size * 100.0 / points
    self.average = ave.round
  end
end