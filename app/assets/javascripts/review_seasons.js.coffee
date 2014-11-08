# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@app.controller 'ReviewSeasonsCtrl', ['$scope', '$http', ($scope, $http) ->
  resetReviewSeason = ->
    $scope.reviewSeason =
      season: null
      start: null
      end: null
      promoStart: null
      promoEnd: null
      repeater: 0.0
      firstTimer: 0.0
      fullReview: 0.0
      doubleReview: 0.0
      coaching: 0.0
      reservation: 0.0

  $scope.addReviewSeason = ->
    resetReviewSeason()
    $scope.reviewSeasonErrors = []
    $scope.btnPrefix = 'Add'

  $scope.editReviewSeason = (r) ->
    $scope.reviewSeasonErrors = []
    $scope.reviewSeason = r
    $scope.reviewSeason._old = angular.copy r
    $scope.btnPrefix = 'Update'

  $scope.resetUnsaved = ->
    for k,v of $scope.reviewSeason._old
      $scope.reviewSeason[k] = v

  $scope.reviewSeasonErrors = []
  res = $http.get '/review_seasons.json'
  res.success (data) ->
    if data == 'null'
      $scope.reviewSeasons = []
    else
      $scope.reviewSeasons = data

  $scope.submitReviewSeason = ->
    $scope.addBtnClass = 'disabled'
    if '_id' of $scope.reviewSeason
      updateReviewSeason()
    else
      createReviewSeason()

  createReviewSeason = ->
    url = '/review_seasons.json'

    r = $http.post url, review_season: $scope.reviewSeason
    r.success (i) ->
      $('#review-season-modal').modal 'hide'
      $scope.addBtnClass = ''
      resetReviewSeason()
      $scope.reviewSeasons.push i

    r.error (d) ->
      $scope.addBtnClass = ''
      $scope.reviewSeasonErrors = []
      for k,vs of d
        for v in vs
          $scope.reviewSeasonErrors.push "#{toHuman(k)} #{v}"

  updateReviewSeason = ->
    url = '/review_seasons/' + $scope.reviewSeason._id.$oid + '.json'
    r = $http.patch url, review_season: $scope.reviewSeason
    r.success (i) ->
      $('#review-season-modal').modal 'hide'
      $scope.addBtnClass = ''
      resetReviewSeason()

    r.error (d) ->
      $scope.addBtnClass = ''
      $scope.reviewSeasonErrors = []
      for k,vs of d
        for v in vs
          $scope.reviewSeasonErrors.push "#{toHuman(k)} #{v}"

  $scope.remove = (r) ->
    id = r._id.$oid
    p = $http.delete "/review_seasons/#{id}.json"
    p.success (d) ->
      confirm = $("#confirm-#{id}")
      confirm.on 'hidden.bs.modal', ->
        idx = $scope.reviewSeasons.indexOf r

        if idx != -1
          $scope.$apply ->
            $scope.reviewSeasons.splice(idx, 1)

      confirm.modal('hide')

    p.error (e) ->
      console.log 'Error removing review season.'
]