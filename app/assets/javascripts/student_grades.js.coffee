window.Grades = Ember.Application.create
  rootElement: '.grades-container'

attr = DS.attr

Grades.Grade = DS.Model.extend
  description: attr(),
  date: attr(),
  points: attr(),
  review_season_id: attr(),
  average: attr(),
  has_timer: attr(),
  is_test: attr(),
  url: attr()

create_grade = (controller) ->
  {
    description: controller.get('title'),
    date: controller.get('date'),
    points: controller.get('points'),
    review_season_id: controller.get('season_id'),
  }

Grades.ApplicationController = Ember.ArrayController.extend
  title: '',
  date: '',
  points: 0,
  season_id: '',
  review_seasons: [],
  actions:
    new: (season_id)->
      this.set('season_id',season_id)
      $('#grade-modal').modal('show')
    , create: ->
      self = this
      $.post(
        '/grades',
        grade: create_grade(self)
      , (data)->
        $('#grade-modal').modal('hide')
        self.store.createRecord('grade', data)
      , 'json'
      ).fail ->
        console.log 'Failed to add grade'

Grades.ApplicationRoute = Ember.Route.extend
  model: ->
    this.store.find('grade')
  ,renderTemplate: ->
    this.render 'grades',
  , setupController: (controller, model) ->
    Ember.$.getJSON('/review_seasons/list.json').then (data) ->
      controller.set('review_seasons',data)
    controller.set('model',model)