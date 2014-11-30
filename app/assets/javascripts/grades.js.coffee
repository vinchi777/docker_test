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

$(document).on 'click', '#students-select-modal .toggle', ->
  self = $(this)
  hidden = self.children('.hidden').removeClass('hidden')
  hidden.siblings().first().addClass('hidden')
  container = $(this).closest('.batch')
  if self.children('.fa-check-circle-o:visible').length
    container.find('a.student').removeClass('excluded')
  else
    container.find('a.student').addClass('excluded')
  count_selected_students(container)
  false

$(document).on 'click', '#students-select-modal a.student', ->
  self = $(this)
  self.toggleClass('excluded')
  count_selected_students(self.closest('.batch'))
  false

count_selected_students = (batch) ->
  count = batch.find('a.student').not('.excluded').length
  batch.find('.count b').text(count).change()

$ ->
  # adjust percent indicator
  $('.grade').each ->
    self = $(this)
    percent = parseInt(self.find('.percent').val())
  # adjust_gauge(1, percent, self)

  $('.new-grade').click ->
    $('#grade-modal').modal('show')
    false

  $('#batch-grades .edit-students').click ->
    $('#students-select-modal').modal('show')
    false

  $('#batch-grades .add-grade, #batch-grades .edit-grade').click ->
    $('#grade-modal').modal('show')
    ###table = $('#batch-grades table')
    $('<td><h6>500 points</h6>NLE Examination</td>').insertBefore(table.find('thead td').last()).hide().fadeIn()
    table.find('tbody tr').each ->
      $("<td><input type='text' class='form-control'></input></td>").insertBefore($(this).find('td').last()).hide().fadeIn()
    do_scroll_x($('#batch-grades .table-wrapper').first(), $(this))###
    false


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

# Start of ember codes
window.Grades = Ember.Application.create
  rootElement: '.grades-container'

Grades.IndexController = Ember.ArrayController.extend
  actions:
    changeName: ->
      this.set('firstname','Wew')

Grades.IndexRoute = Ember.Route.extend
  model: ->
    Ember.$.getJSON('/grades/grades_per_season.json')
  ,renderTemplate: ->
    this.render 'grades'

###grades = [
  {
    description: 'April 2013',
    grades: [
      {score: 100, points: 100, description: 'NLT Mockup', date: 'December 9', timer: true, test:true},
      {score: 200, points: 500, description: 'Mock Exam', date: 'August 15', timer: false, test:false},
    ]
  },
  {
    description: 'April 2012',
    grades: [
      {score: 100, points: 100, description: 'NLT Mockup', date: 'December 9', timer: true, test:true}
    ]
  },
]###
###console.log '------------'
grades =
console.log grades###

