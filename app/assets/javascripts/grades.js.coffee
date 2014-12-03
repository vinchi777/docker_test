# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  count_selected_students($('#students-select-modal.primitive'))

  # adjust percent indicator
  $('.grade').each ->
    self = $(this)
    percent = parseInt(self.find('.percent').val())
  # adjust_gauge(1, percent, self)

  ###$('.new-grade').click ->
    $('#grade-modal').modal('show')
    false###

  $('#batch-grades .edit-students').click ->
    $('#students-select-modal').modal('show')
    false

  update_percents()
  $('#batch-grades .total-score').on 'change keyup', ->
    update_percents()

  #Search
  $('#batch-grades input.search-existing-students').keyup ->
    q = $(this).val().toLowerCase()
    $('#batch-grades .student-list tr').each ->
      self = $(this)
      student = self.data('query').toLowerCase()
      if student.indexOf(q) == -1
        self.fadeOut()
      else
        self.fadeIn()

  #Search in student select modal
  $('#students-select-modal.primitive input.search-students').keyup ->
    q = $(this).val().toLowerCase()
    $('#students-select-modal.primitive .student').each ->
      self = $(this)
      student = self.data('query').toLowerCase()
      if student.indexOf(q) == -1
        self.fadeOut()
      else
        self.fadeIn()


# For table effects
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


# For select student modal
$(document).on 'click', '#students-select-modal.primitive .toggle', ->
  self = $(this)
  container = $('#students-select-modal.primitive')
  counts = get_counts(container)

  if counts.count != counts.total_count
    container.find('a.student').removeClass('excluded')
  else
    container.find('a.student').addClass('excluded')

  count_selected_students(container)
  false

$(document).on 'click', '#students-select-modal.primitive a.student', ->
  self = $(this)
  self.toggleClass('excluded')
  count_selected_students($('#students-select-modal.primitive'))
  false

get_counts = (container) ->
  count = container.find('a.student:not(.excluded)').length
  total_count = parseInt container.find('.total-count').text()
  {count: count, total_count: total_count}

count_selected_students = (container) ->
  counts = get_counts(container)
  container.find('.batch-count').text(counts.count)
  toggle_select_icons(container, counts)

toggle_select_icons = (container, counts) ->
  toggle = container.find('.toggle')

  toggle.children().addClass('hide')
  if counts.count == 0
    toggle.find('.fa-check-circle-o').removeClass('hide')
  else if counts.count == counts.total_count
    toggle.find('.fa-circle-o').removeClass('hide')
  else
    toggle.find('.fa-dot-circle-o').removeClass('hide')


# Update_percents in grades
update_percents = ->
  $('.student-list tr').each ->
    update_percent($(this))

$(document).on 'change keyup', '#batch-grades .student-list input', ->
  self = $(this)
  parent = self.closest('tr')
  update_percent(parent, self)

update_percent = (student_container, input) ->
  pr = student_container.find('.pr')
  input = if input == undefined then student_container.find('.form-control') else input
  points = safe_float_val($('#batch-grades .total-score'))
  score = safe_float_val(input)
  percentage = score / points * 100
  percentage = Math.round(percentage)
  percentage = 0 if isNaN(percentage) || percentage == Infinity
  pr.text(percentage)


# Percentage gauge indicator for index
adjust_gauge = (level, percent, container) ->
  if percent <= 0
    return
  else if percent >= 25
    deg = 0
  else
    deg = 90 - percent / 25 * 90

  arc = container.find(".arc#{level}")
  arc.css('transform', "rotate(#{90 * level}deg) skewX(#{deg}deg)")
  arc.attr('data-content', arc_style(deg))

  adjust_gauge(level + 1, percent - 25, container)

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