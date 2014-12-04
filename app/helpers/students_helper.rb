module StudentsHelper
  def placeholder_pic
    'user.png'
  end

  def sorted_enrollments
    @student.enrollments.sort { |a, b| b.season_start <=> a.season_start }
  end

  def grades_in_enrollment(enrollment)
    enrollment.student_grades.sort { |a, b| b.date <=> a.date }
  end
end
