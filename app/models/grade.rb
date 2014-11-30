class Grade
  include Mongoid::Document
  field :description, type: String
  field :date, type: Date
  field :points, type: Integer

  belongs_to :review_season
  has_many :student_grades, dependent: :destroy
end