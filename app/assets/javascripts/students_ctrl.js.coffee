@app.controller 'StudentsCtrl', ['$scope', '$http', ($scope, $http) ->
  $students = $('#students')
  $scope.currentPage = $students.data 'page'
  $scope.q = $students.data 'q'
  $scope.maxSize = 5
  $scope.students = []

  params = {}

  loadStudents = ->
    $scope.loading = true
    url = '/students.json'
    r = $http.get url, params: params
    r.success (d) ->
      $scope.loading = false
      $scope.students = d.students
      $scope.totalItems = d.totalSize
      window.history.pushState({}, '', '/students?' + $.param(params))

    r.error (e) ->
      $scope.loading = false

  loadSeasons = ->
    url = '/review_seasons.json'
    r = $http.get url
    r.success (d) ->
      d.push {season: 'All', id: 0}
      $scope.seasons = d
      $scope.season = d[d.length - 1]

  loadEnrollmentStatus = ->
    r = $http.get '/students/enrollment_status'
    r.success (d) ->
      d.push {key: 'All', value: -1}
      $scope.enrollment_statuses = d
      $scope.enrollment_status = d[d.length - 1]

  $scope.filter = ->
    params =
      season: $scope.season.id
      status: $scope.enrollment_status.value
    loadStudents()

  $scope.search = ->
    params =
      q: $scope.q
    $scope.currentPage = 1
    loadStudents()

  $scope.pageChanged = ->
    params =
      page: $scope.currentPage
      q: $scope.q
    loadStudents()

  $scope.remove = (u) ->
    p = $http.delete "/students/#{u.id}.json"
    p.success (d) ->
      confirm = $("#confirm-#{u.id}")
      confirm.on 'hidden.bs.modal', ->
        idx = $scope.students.indexOf u

        if idx != -1
          $scope.$apply ->
            $scope.students.splice(idx, 1)
            $scope.totalItems--

      confirm.modal('hide')

    p.error (e) ->
      $scope.deleteError = e.message
      $("#confirm-#{u.id}").modal 'hide'
      $('#error-delete').modal 'show'

  if $scope.currentPage
    params['page'] = $scope.currentPage

  if $scope.q
    params['q'] = $scope.q

  loadStudents()
  loadSeasons()
  loadEnrollmentStatus()

  $scope.confirm = (s) -> confirmEnrollment($scope, $http, s)

  $scope.profile_pic_exists = (s) ->
    s.profile_pic != null
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