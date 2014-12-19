# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@app.controller 'TestCtrl', ['$scope', '$http', ($scope, $http) ->
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
    r = $http.get "/tests/#{id}.json"
    r.success (d) ->
      if d.questions.length <= 0
        $scope.addQuestion(d)
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

  $scope.copyTest = ->
    console.log($scope.test.id)
    p = $http.post "/tests/#{$scope.test.id}/copy.json"
    p.success (d) ->
      window.location = d.url

  $scope.selectStudents = ->
    $scope.$broadcast 'student_modal_show', $scope.test.review_season

  $scope.$on 'students_selected', (e, a) ->
    params =
      students: (s.id for s in a)
    $scope.publishing = true

    r = $http.patch "/tests/#{$scope.test.id}/publish.json", params
    r.success (d) ->
      $scope.publishing = false
      $('#students-select-modal').modal('hide')
    r.error (e) ->
      $scope.publishing = false
      $('#students-select-modal').modal('hide')
]

@app.controller 'TestsCtrl', ['$scope', '$http', ($scope, $http) ->
  r = $http.get "/tests.json"
  r.success (d) ->
    $scope.tests = d
]