class Grade
  include Mongoid::Document
  field :description, type: String
  field :date, type: Date
  field :points, type: Integer
  field :average, type: Integer, default: 0

  belongs_to :review_season
  has_many :student_grades, dependent: :destroy
end