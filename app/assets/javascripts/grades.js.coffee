# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', 'table tr *', ->
  $(this).closest('table').find('tr.current').removeClass 'current'
  $(this).closest('tr').addClass 'current'

$(document).on 'click', 'table td .form-control', ->
  table = $(this).closest('table')
  table.find('thead .active').removeClass 'active'
  td = $(this).closest('td')
  index = td.index()
  if index > 0 && index < td.siblings().length
    target = table.find('thead td')[index]
    $(target).addClass 'active'

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

  arc = container.find(".arc#{level}")
  arc.css('transform', "rotate(#{90*level}deg) skewX(#{deg}deg)")
  arc.attr('data-content',arc_style(deg))

  adjust_gauge(level+1, percent-25, container)

arc_style = (deg) ->
  """
  box-sizing: border-box;
  display: block;
  border: solid @border-size @green;
  width: 200%;
  height: 200%;
  border-radius: 50%;
  transform: skewX(#{-deg}def);
  content: '';
  """


