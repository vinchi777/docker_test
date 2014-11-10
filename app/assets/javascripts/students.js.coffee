# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Boostrap Datepicker
$ ->
  $('.student a.remove').click (e) ->
    e.preventDefault()
    $this = $(this)
    $.ajax
      url: $(this).attr('href')
      type: 'delete'
      success: ->
        location.reload()
