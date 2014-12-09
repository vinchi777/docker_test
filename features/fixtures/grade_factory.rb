class GradeFactory
  def self.createGrade
    self.create
  end

  def self.createGradeWithStudents
    enrs = StudentEnrollment.enrolled
    enrollments = [
        {score: 50, student_enrollment: enrs.first},
        {score: 49, student_enrollment: enrs.last}
    ]
    self.create enrollments
  end

  def self.createGradeWithStudent
    enrs = StudentEnrollment.enrolled
    enrollments = [{score: 50, student_enrollment: enrs.first}]
    self.create enrollments
  end

  def self.create(enrollments = [])
    Grade.create!({
                      description: 'NLE Examination',
                      date: DateTime.now,
                      points: 50,
                      review_season: ReviewSeason.current,
                      student_grades_attributes: enrollments
                  })
  end
end