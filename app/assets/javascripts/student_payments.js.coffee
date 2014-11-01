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