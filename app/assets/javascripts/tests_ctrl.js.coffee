# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@app.controller 'TestCtrl', ['$scope', '$http', 'Test', ($scope, $http, Test) ->
  $scope.errors = []
  $scope.test = {
    description: ''
    date: null
    deadline: null
    timer: 0
    random: false
    questions: [
      {
        text: ''
        choice1: ''
        choice2: ''
        choice3: ''
        choice4: ''
      }
    ]
  }

  $scope.addQuestion = (t) ->
    t.questions.push {
      text: ''
      choice1: ''
      choice2: ''
      choice3: ''
      choice4: ''
    }

  $scope.load = (id) ->
    Test.get id: id, (d) ->
      $scope.test = d

  $scope.save = ->
    r = if $scope.test.id
      $http.patch "/tests/#{$scope.test.id}.json", test: $scope.test
    else
      $http.post '/tests.json', test: $scope.test
    $scope.saving = true
    $scope.errors = []

    r.success (d) ->
      $scope.saving = false
      $scope.test = d
      window.history.pushState({}, '', d.url)

    r.error (d) ->
      $scope.saving = false
      $scope.errors = []
      for k,vs of d
        for v in vs
          $scope.errors.push "#{toHuman(k)} #{v}" unless "#{toHuman(k)} #{v}" in $scope.errors


  $scope.publish = ->
    r = $http.patch "tests/#{$scope.test.id}/publish.json"
    $scope.publishing = true
    r.success (d) ->
      $scope.publishing = false

  $scope.selectStudents = ->
    $scope.$broadcast 'student_modal_show', null
]

@app.controller 'TestsCtrl', ['$scope', '$http', 'Test', ($scope, $http, Test) ->
  Test.query (d) ->
    $scope.tests = d
]