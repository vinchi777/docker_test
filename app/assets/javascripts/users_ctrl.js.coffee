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

  $userPage = $('#users')
  $scope.currentPage = $userPage.data 'page'
  $scope.q = $userPage.data 'q'
  $scope.maxSize = 5
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
    params =
      q: $scope.q
    $scope.currentPage = 1
    loadUsers()

  $scope.pageChanged = ->
    params =
      page: $scope.currentPage
      q: $scope.q
    loadUsers()

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

  $scope.remove = (u) ->
    p = $http.delete "/users/#{u.id}.json"
    p.success (d) ->
      confirm = $("#confirm-#{u.id}")
      confirm.on 'hidden.bs.modal', ->
        idx = $scope.users.indexOf u

        if idx != -1
          $scope.$apply ->
            $scope.users.splice(idx, 1)

      confirm.modal('hide')

    p.error (e) ->
      $scope.deleteError = e.message
      $("#confirm-#{u.id}").modal 'hide'
      $('#error-delete').modal 'show'

  if $scope.currentPage
    params['page'] = $scope.currentPage

  if $scope.q
    params['q'] = $scope.q

  loadUsers()
]