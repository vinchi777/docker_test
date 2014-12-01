#$ ->
#  if $('#batch-grades')
#    window.BatchGrade = Ember.Application.create
#      rootElement: '#batch-grades'
#
#    attr = DS.attr
#
#    ###
#    BatchGrades.StudentEnrollment = DS.Model.extend
#      profile_pic: attr()
#      lastName: attr()
#      firstName: attr()
#      middleInitial: attr()
#      studentgrades: DS.hasMany 'studentgrade'
#    ###
#    ###
#    BatchGrades.Grade = DS.Model.extend
#      description: attr()
#      date: attr()
#      points: attr()
#      review_season_id: attr()###
#
#    BatchGrade.Grade = DS.Model.extend
#      score: attr('number', {defaultValue: 0})
#      student_enrollment_id: attr()
#      profile_pic: attr()
#      lastName: attr()
#      firstName: attr()
#      middleInitial: attr()
#      percent: ->
#        score / grade.points * 100
#
#    BatchGrade.ApplicationController = Ember.ArrayController.extend
#      description: 'Desc'
#      date: ''
#      points: ''
#      review_season_id: ''
#      id: ''
#
#    BatchGrade.ApplicationRouter = Ember.Route.extend
#      model: ->
#        store = this.store
#        Ember.$.getJSON('/grades/current_enrollments.json').then (data)->
#          for d in data.studentenrollments
#            store.push('grade', to_grade(d))
#          store.all('grade')
#      renderTemplate: ->
#        this.render 'batch_grade'
#
#    to_grade = (data) ->
#      student_enrollment_id: data.id
#      profile_pic: data.profile_pic
#      lastName: data.lastName
#      firstName: data.firstName
#      middleInitial: data.middleInitial

$ ->
  $('#batch-grades input.search-students').keyup ->
    q = $(this).val().toLowerCase()
    $('#batch-grades .student-list tr').each ->
      self = $(this)
      student = self.data('query').toLowerCase()
      if student.indexOf(q) == -1
        self.fadeOut()
      else
        self.fadeIn()