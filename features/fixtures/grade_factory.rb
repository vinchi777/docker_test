class GradeFactory
  def self.createGrade
    Grade.create!({
                      description: 'NLE Examination',
                      date: DateTime.now,
                      points: 50,
                      review_season: ReviewSeason.current,
                  })
  end

  def self.createGradeWithStudents
    enrs = StudentEnrollment.enrolled
    Grade.create!({
                      description: 'NLE Examination',
                      date: DateTime.now,
                      points: 50,
                      review_season: ReviewSeason.current,
                      student_grades_attributes: [
                          {score: 50, student_enrollment: enrs.first},
                          {score: 49, student_enrollment: enrs.last}
                      ]
                  })
  end
end