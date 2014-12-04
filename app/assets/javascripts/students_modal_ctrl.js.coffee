@app.controller 'StudentsModalCtrl', ['$scope', '$http', 'ReviewSeason',
  ($scope, $http, ReviewSeason) ->
    $scope.selected = []
    $scope.students = []

    loadStudents = ->
      params =
        season: $scope.season.id
        per_page: 0
        status: 2 # enrolled
      r = $http.get '/students.json', params: params
      r.success (d) ->
        $scope.students = d.students
        $scope.totalSize = d.totalSize
        $scope.selected = []

    $scope.toggle = (s) ->
      s.selected = !s.selected

      if s.selected
        $scope.selected.push s
      else
        idx = $scope.selected.indexOf
        $scope.selected.splice(idx, 1) if idx != -1

    # a - Review season obj
    $scope.$on 'student_modal_show', (e, a) ->
      $scope.season = a
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