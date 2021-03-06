module StudentsHelper
  def placeholder_pic
    'user.png'
  end

  def sorted_enrollments
    @student.enrollments.sort { |a, b| b.review_season.season_start <=> a.review_season.season_start }
  end

  def grades_in_enrollment(enrollment)
    grades = enrollment.student_grades + enrollment.answer_sheets.select { |s| s.deadline? }
    grades.sort { |a, b| b.date <=> a.date }
  end
end
