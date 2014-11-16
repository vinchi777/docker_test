@app.controller 'UsersCtrl', ['$scope', '$http', ($scope, $http) ->
  resetUser = ->
    $scope.user = {
      password: null
      password_confirmation: null
    }

    $scope.person = {
      firstName: null
      middleName: null
      lastName: null
      email: null
    }

  $scope.users = []
  params = []

  loadUsers = ->
    $scope.loading = true
    url = '/users.json'
    r = $http.get url, params: params
    r.success (d) ->
      $scope.loading = false
      $scope.users = d.users
      $scope.totalItems = d.totalSize
      window.history.pushState({}, '', '/users?' + $.param(params))

  $scope.search = ->

  $scope.add = ->
    $scope.userErrors = []
    resetUser()

  $scope.create = (url) ->
    $scope.addBtnClass = 'disabled'
    params =
      user: $scope.user
      person: $scope.person

    r = $http.post url + '.json', params

    r.success (i) ->
      $('#user-modal').modal 'hide'
      $scope.addBtnClass = ''
      resetUser()
      $scope.users.push i

    r.error (d) ->
      $scope.addBtnClass = ''
      $scope.userErrors = []
      for j,vj of d
        for k,vs of vj
          for v in vs
            $scope.userErrors.push "#{toHuman(k)} #{v}"

  loadUsers()
  resetUser()
]