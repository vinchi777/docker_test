@app.controller 'UsersCtrl', ['$scope', '$http', ($scope, $http) ->
#  $students = $('#students')
#  $scope.currentPage = $students.data 'page'
#  $scope.q = $students.data 'q'
#  $scope.maxSize = 5
#
#  params = {}
#
#  loadStudents = ->
#    $scope.loading = true
#    url = '/students.json'
#    r = $http.get url, params: params
#    r.success (d) ->
#      $scope.loading = false
#      $scope.students = d.students
#      $scope.totalItems = d.totalSize
#      window.history.pushState({}, '', '/students?' + $.param(params))
#
#  $scope.search = ->
#    params =
#      q: $scope.q
#    $scope.currentPage = 1
#    loadStudents()
#
#  $scope.pageChanged = ->
#    params =
#      page: $scope.currentPage
#      q: $scope.q
#    loadStudents()
#
#  if $scope.currentPage
#    params['page'] = $scope.currentPage
#
#  if $scope.q
#    params['q'] = $scope.q
#
#  loadStudents()
#
#  $scope.confirm = (s) -> confirmEnrollment($scope, $http, s)
#
#  $scope.profile_pic_exists = (s) ->
#    s.profile_pic != null
]
#
#@app.controller 'StudentCtrl', ['$scope', '$http', ($scope, $http) ->
#  $scope.setStudent = (id) ->
#    r = $http.get "/students/#{id}.json"
#    r.success (d) ->
#      $scope.student = d
#
#  $scope.confirm = (s) -> confirmEnrollment($scope, $http, s)
#]
#
#@confirmEnrollment = ($scope, $http, s) ->
#  r = $http.put "/students/#{s.id}/confirm.json"
#  r.success (d) ->
#    s.enrollment_status = d.enrollment_status
#  r.error ->
#    alert 'not confirmed'