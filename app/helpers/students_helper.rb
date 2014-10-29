module StudentsHelper

  def enrollment_status(student)
    # res =
    #     if !student.status.nil? && student.status.name == 'Enrolled'
    #       '<i class="fa fa-lg fa-check"></i> ' + student[:status][:name] + ' ' + student[:status][:season]
    #     elsif !student.status.nil? && student.status.name == 'Enrolling'
    #       '<i class="fa fa-lg fa-clock-o"></i> ' + student[:status][:name] + ' for ' + student[:status][:season]
    #     end
    #
    # raw(res)
  end

  def payment_status(student)
    # res =
    #     if student.balance.nil?
    #       ''
    #     else
    #       '<i class="fa fa-lg fa-money"></i>' +
    #           number_to_currency(student[:balance], unit: 'Php', format: '%u %n')
    #     end
    # raw(res)
  end
end
