# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # New Invoice Validation
  $('#invoice-modal form').submit (e) ->
    e.preventDefault()
    $this = $(this)
    url = $this.attr('action')
    data = $this.serialize()

    btn = $this.find 'input[type="submit"]'
    btn.addClass('disabled')

    $.ajax
      url: url
      type: 'post'
      data: data
      success: ->
        location.reload()
      error: (xhr, status, e) ->
        data = JSON.parse xhr.responseText
        btn.removeClass('disabled')
        ul = $this.find('.error.panel ul')
        $('.error.panel li').remove()
        show = false

        if data.package != undefined
          for e in data.package
            ul.append "<li>Package #{e}</li>"
            show = true

        if data.description != undefined
          for e in data.description
            ul.append "<li>Description #{e}</li>"
            show = true

        if data.review_seasons != undefined
          for e in data.review_seasons
            ul.append "<li>Review season(s) #{e}</li>"
            show = true

        if data.amount != undefined
          for e in data.amount
            ul.append "<li>Amount #{e}</li>"
            show = true

        if data.discount != undefined
          for e in data.discount
            ul.append "<li>Discount #{e}</li>"
            show = true

        if show
          $('.error.panel').removeClass 'hide'

#  $('.invoice a.remove').click (e) ->
#    e.preventDefault()
#    $this = $(this)
#    $.ajax
#      url: $(this).attr('href')
#      type: 'delete'
#      data:
#        student_id: $(this).data('student')
#      success: ->
#        location.reload()
#      error: ->
#        console.log 'Error'

#  $('.invoice').hover(
#    -> $(this).find('.trash a').show()
#    ,
#    -> $(this).find('.trash a').hide()
#  )

@StudentPaymentCtrl = ($scope, $http) ->
  studentId = $('.invoices').data 'student-id'
  res = $http.get('/student_invoices.json?id=' + studentId)
  res.success (data) ->
    if data == 'null'
      $scope.invoices = []
    else
      $scope.invoices = data
      for i in $scope.invoices
        resetTransaction(i)

  resetTransaction = (i) ->
    i.transaction = {
      date: ''
      or: ''
      method: ''
      amount: ''
    }

  $scope.balance = (i) ->
    if i.discount != ''
      i.amount * i.discount
    else
      i.amount

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
          i.transactions.push i.transaction
          resetTransaction(i)
          i.showTransaction = false

  $scope.showTransaction = (i) ->
    i.showTransaction = true

  $scope.hideTransaction = (i) ->
    i.showTransaction = false