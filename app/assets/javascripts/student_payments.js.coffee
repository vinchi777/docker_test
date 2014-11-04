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
  res = $http.get('/student_payments.json?id=' + studentId)
  res.success (data) ->
    if data == 'null'
      $scope.invoices = []
    else
      $scope.invoices = data

  $scope.balance = (i) ->
    if i.discount != ''
      i.amount * i.discount
    else
      i.amount

  $scope.remove = (id) ->
    r = $http.delete("/student_payments/#{id}.json?student_id=#{studentId}")

    r.success (data) ->
      $("confirm-#{id}").modal
        show: false

    r.error (e) ->
      console.log 'Error removing invoice.'