module StudentsHelper

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

  def placeholder_pic
    'user.png'
  end
end
