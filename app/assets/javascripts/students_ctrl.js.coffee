@app.controller 'StudentsCtrl', ['$scope', '$http', ($scope, $http) ->
  $students = $('#students')
  page = $students.data 'page'
  $scope.q = $students.data 'q'

  params = {}

  if page
    params['page'] = page

  if $scope.q
    params['q'] = $scope.q

  r = $http.get '/students.json', params: params
  r.success (d) ->
    $scope.students = d

  $scope.confirm = (s) -> confirmEnrollment($scope, $http, s)

]

@app.controller 'StudentCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.setStudent = (id) ->
    r = $http.get "/students/#{id}.json"
    r.success (d) ->
      $scope.student = d

  $scope.confirm = (s) -> confirmEnrollment($scope, $http, s)
]

@confirmEnrollment = ($scope, $http, s) ->
  r = $http.put "/students/#{s.id}/confirm.json"
  r.success (d) ->
    s.enrollment_status = d.enrollment_status
  r.error ->
    alert 'not confirmed'