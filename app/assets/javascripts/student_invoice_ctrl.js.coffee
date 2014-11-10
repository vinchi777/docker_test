# Extracted from Morph https://github.com/cmoncrief/morph
@capFirst = (input) ->
  "#{input[0].toUpperCase()}#{input.slice 1}"

# Extracted from Morph https://github.com/cmoncrief/morph
@toHuman = (input, cap = true) =>
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
    unless 'transactions' of i
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

  $scope.addInvoice = ->
    res = $http.get '/review_seasons/list.json'
    res.success (d) ->
      $scope.reviewSeasons = d

  $scope.createInvoice = (url) ->
    $scope.addInvoiceClass = 'disabled'

    r = $http.post url + '.json', student_invoice: $scope.invoice
    r.success (i) ->
      $('#invoice-modal').modal('hide')
      $scope.addInvoiceClass = ''
      addEmptyTransactions(i)
      resetInvoice()
      resetTransaction(i)
      $scope.invoices.push i

    r.error (d) ->
      $scope.addInvoiceClass = ''
      $scope.invoiceErrors = []
      for k,vs of d
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
    params =
      student_id: studentId

    r = $http.delete "/student_invoices/#{id}.json", params: params
    r.success (d) ->
      confirm = $("#confirm-#{id}")
      confirm.on 'hidden.bs.modal', ->
        idx = $scope.invoices.indexOf i

        if idx != -1
          $scope.$apply ->
            $scope.invoices.splice(idx, 1)

      confirm.modal('hide')

    r.error (e) ->
      console.log 'Error removing invoice.'

  $scope.saveTransaction = (i) ->
    id = i._id.$oid
    data =
      student_id: studentId
      transaction: i.transaction

    r = $http.post "/student_invoices/#{id}/transaction.json", data

    r.success (d)->
      i.transactions = d.transactions
      resetTransaction(i)
      i.showTransaction = false
      i.transactionErrors = []

    r.error (d, s) ->
      i.transactionErrors = []
      for k,vs of d
        for v in vs
          i.transactionErrors.push "#{toHuman(k)} #{v}"

  $scope.removeTransaction = (i, t) ->
    id = i._id.$oid
    data =
      transaction:
        tr_id: t._id.$oid
      student_id: studentId

    r = $http.post "/student_invoices/#{id}/transaction/destroy.json", data

    r.success (d) ->
      confirm = $("#confirm-tr-#{t._id.$oid}")
      confirm.on 'hidden.bs.modal', ->
        $scope.$apply ->
          idx = i.transactions.indexOf t
          if idx != -1
            i.transactions.splice(idx, 1)

      confirm.modal 'hide'

    r.error (d, s) ->
      console.log 'not deleted'

  $scope.showTransaction = (i) ->
    i.showTransaction = true

  $scope.hideTransaction = (i) ->
    i.transactionErrors = []
    i.showTransaction = false
]