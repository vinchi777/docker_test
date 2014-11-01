# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
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


