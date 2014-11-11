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

  $('#students ul.pagination li:first-child a').html '<i class="fa fa-chevron-circle-left"></i>'
  $('#students ul.pagination li:nth-child(2) a').html '<i class="fa fa-chevron-left"></i>'
  $('#students ul.pagination li:nth-last-child(2) a').html '<i class="fa fa-chevron-right"></i>'
  $('#students ul.pagination li:last-child a').html '<i class="fa fa-chevron-circle-right"></i>'

  $('#students .loading').height($('.admin-container').height() - 285)
