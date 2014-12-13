@app.controller 'TestResultCtrl', ['$scope', '$http', ($scope, $http) ->
  id = ''
  $scope.init = (i) ->
    id = i
    loadStudents()

  loadStudents = ->
    $http.get("/tests/#{id}/results.json").success (d) ->
      $scope.students = d.students
      $scope.test = d.test
]
