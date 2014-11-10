module StudentsHelper

  def enrollment_status(student)
    res =
        if student.enrolled?
          '<i class="fa fa-lg fa-check"></i> Enrolled for ' + student.current_season
        elsif student.enrolling?
          '<i class="fa fa-lg fa-clock-o"></i> Enrolling for ' + student.current_season
        end

    raw(res)
  end

  def payment_status(student)
    res =
        if student.has_balance?
          '<i class="fa fa-lg fa-money"></i>' +
              number_to_currency(student.balance, unit: 'Php', format: '%u %n')
        else
          ''
        end
    raw(res)
  end
end
