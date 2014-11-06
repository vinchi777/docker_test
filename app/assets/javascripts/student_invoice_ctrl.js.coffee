# Extracted from Morph https://github.com/cmoncrief/morph
capFirst = (input) ->
  "#{input[0].toUpperCase()}#{input.slice 1}"

# Extracted from Morph https://github.com/cmoncrief/morph
toHuman = (input, cap = true) =>
  output = input.replace /[-._]/g, ' '
  output = output.replace /([A-Z\d])([A-Z][a-z\d])/g, '$1 $2'
  output = output.replace /([a-z])([A-Z])/g, '$1 $2'
  output = output.replace /(\s([a-zA-Z])\s)/g, (str, p1) -> "#{p1.toLowerCase()}"
  output = output.replace /([A-Z])([a-z])/g, (str, p1, p2) -> "#{p1.toLowerCase()}#{p2}"
  output = if cap then capFirst output else lowerFirst output
  return output

@app.controller 'StudentPaymentCtrl', ['$scope', '$http', ($scope, $http) ->
  studentId = $('.invoices').data 'student-id'

  resetTransaction = (i) ->
    i.transaction = {
      date: ''
      or_no: ''
      method: ''
      amount: 0
    }

  resetInvoice = ->
    $scope.invoice = {
      amount: 0
      discount: 0
      student_id: studentId
    }

  addEmptyTransactions = (i) ->
    if !i.hasOwnProperty 'transactions'
      i.transactions = []

  res = $http.get('/student_invoices.json?id=' + studentId)
  res.success (data) ->
    if data == 'null'
      $scope.invoices = []
    else
      $scope.invoices = data
      for i in $scope.invoices
        resetTransaction(i)
        addEmptyTransactions(i)

  $scope.enableAddInvoiceBtn = true
  resetInvoice()

  $scope.createInvoice = ->
    $this = $('#invoice-modal form')
    url = $this.data('url')

    btn = $this.find 'input[type="submit"]'
    btn.addClass('disabled')

    $.ajax
      url: url
      type: 'post'
      data:
        student_invoice: $scope.invoice
      success: (i) ->
        $('#invoice-modal').modal('hide')
        btn.removeClass('disabled')

        $scope.$apply ->
          addEmptyTransactions(i)
          resetInvoice()
          resetTransaction(i)
          $scope.invoices.push i

      error: (xhr, status, e) ->
        data = JSON.parse xhr.responseText
        btn.removeClass('disabled')

        $scope.$apply ->
          $scope.invoiceErrors = []

          for k,vs of data
            for v in vs
              $scope.invoiceErrors.push "#{toHuman(k)} #{v}"

  $scope.total = (i) ->
    i.amount * (1 - i.discount)

  $scope.balance = (i) ->
    totalTransaction =
      if i.transactions.length != 0
        i.transactions.map((t) -> parseFloat(t.amount)).reduce((t, s) -> t + s)
      else
        0

    $scope.total(i) - totalTransaction - i.transaction.amount

  $scope.remove = (i) ->
    id = i._id.$oid
    data =
      student_id: studentId

    $.ajax
      url: "/student_invoices/#{id}.json"
      data: data
      method: 'DELETE'
      success: (data) ->
        confirm = $("#confirm-#{id}")
        confirm.on 'hidden.bs.modal', ->
          idx = $scope.invoices.indexOf i

          if idx != -1
            $scope.$apply ->
              $scope.invoices.splice(idx, 1)

        confirm.modal('hide')

      error: (e) ->
        console.log 'Error removing invoice.'

  $scope.saveTransaction = (i) ->
    id = i._id.$oid
    data =
      student_id: studentId
      transaction: i.transaction

    $.ajax
      url: "/student_invoices/#{id}/transaction"
      data: data
      method: 'POST'
      success: (data) ->
        $scope.$apply ->
          i.transactions = data.transactions
          resetTransaction(i)
          i.showTransaction = false
          i.transactionErrors = []

      error: (xhr, status, e) ->
        data = JSON.parse xhr.responseText

        $scope.$apply ->
          i.transactionErrors = []

          for k,vs of data
            for v in vs
              i.transactionErrors.push "#{toHuman(k)} #{v}"

  $scope.removeTransaction = (i, t) ->
    id = i._id.$oid
    data =
      transaction:
        tr_id: t._id.$oid
      student_id: studentId

    $.ajax
      url: "/student_invoices/#{id}/transaction"
      data: data
      method: 'DELETE'
      success: (data) ->
        confirm = $("#confirm-tr-#{t._id.$oid}")
        confirm.on 'hidden.bs.modal', ->
          idx = i.transactions.indexOf t

          if idx != -1
            $scope.$apply ->
              i.transactions.splice(idx, 1)

        confirm.modal 'hide'

      error: (e) ->
        console.log 'not deleted'


  $scope.showTransaction = (i) ->
    i.showTransaction = true

  $scope.hideTransaction = (i) ->
    i.transactionErrors = []
    i.showTransaction = false
]