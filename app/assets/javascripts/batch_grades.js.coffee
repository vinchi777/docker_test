window.BatchGrades = Ember.Application.create
  rootElement: '#batch-grades'

attr = DS.attr

BatchGrades.StudentEnrollment = DS.Model.extend
  profile_pic: attr()
  lastName: attr()
  firstName: attr()
  middleInitial: attr()
  studentgrades: DS.hasMany 'studentgrade'


BatchGrades.StudentGrade = DS.Model.extend
  score: attr()
  studentenrollment:
  grade: DS.belongsTo 'grade'

BatchGrades.Grade = DS.Model.extend
  description: attr()
  date: attr()
  points: attr()
  review_season_id: attr()
  studentgrades: DS.hasMany 'studentgrade'

