@app.controller 'StudentsModalCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.selected = []
  $scope.students = []
  id = ''

  loadStudents = ->
    r = $http.get "/tests/#{id}/students.json"
    r.success (d) ->
      $scope.students = d.students
      $scope.totalSize = d.totalSize
      $scope.selected = []
      for s in $scope.students
        s.selected = true
        $scope.selected.push s

  $scope.toggle = (s) ->
    s.selected = !s.selected

    if s.selected
      $scope.selected.push s
    else
      idx = $scope.selected.indexOf
      $scope.selected.splice(idx, 1) if idx != -1

  # a - Review season obj
  # id - Test id
  $scope.$on 'student_modal_show', (e, a, i) ->
    $scope.filter = ''
    $scope.season = a
    id = i
    loadStudents()

  $scope.toggleAll = ->
    if $scope.selected.length == $scope.students.length
      $scope.selected = []
      s.selected = false for s in $scope.students
    else
      $scope.selected = angular.copy $scope.students
      s.selected = true for s in $scope.students

  $scope.commit = ->
    $scope.$emit 'students_selected', $scope.selected

]