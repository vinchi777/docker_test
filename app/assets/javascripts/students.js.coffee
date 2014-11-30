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

  $('#students .loading').height($('.admin-container').height() - 285)

$(document).on 'change', 'input[type="file"].preview', ->
  preview_img this

preview_img = (input) ->
  preview = $('.profile-pic img.profile')
  if input.files && input.files[0] && preview
    reader = new FileReader()

    reader.onload = (e) ->
      img = $(preview[0])
      img.attr 'src', e.target.result

      $('.profile-pic .clean').val false

    reader.readAsDataURL input.files[0]