class Grade
  include Mongoid::Document
  field :description, type: String
  field :date, type: Date
  field :points, type: Integer
  field :average, type: Float, default: 0

  belongs_to :review_season
  has_many :student_grades, dependent: :destroy
  accepts_nested_attributes_for :student_grades

  validates_presence_of :description
  validates_presence_of :date
  validates_presence_of :points

  before_save :calculate_average
  after_save :post_process_grades

  def test?
    false
  end

  def timer?
    test?
  end

  def calculate_average
    sum = 0
    size = 0

    self.student_grades.each do |g|
      if g.to_delete
        g.destroy
      else
        sum += g.score
        size += 1
      end
    end

    if sum == 0
      self.average = 0
    else
      self.average = sum.to_d / size * 100 / points
    end
  end

  def post_process_grades
    student_grades.delete_all(to_delete: true)
  end
end