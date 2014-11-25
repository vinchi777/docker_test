# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # adjust percent indicator
  $('.grade').each ->
    self = $(this)
    percent = parseInt(self.find('.percent').val())
    # adjust_gauge(1, percent, self)

  $('.new-grade').click ->
    $('#grade-modal').modal('show');



adjust_gauge = (level, percent, container) ->
  if percent <= 0
    return
  else if percent >= 25
    deg = 0
  else
    deg = 90 - percent / 25 * 90

  container.find(".arc#{level}").css('transform', "rotate(#{90*level}deg) skewX(#{deg}deg)")
  container.find(".arc#{level}:before").css('transform', "skewX(#{-deg}deg) !important")

  adjust_gauge(level+1, percent-25, container)



