# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@app.controller 'ReviewSeasonsCtrl', ['scope', '$http', ($scope, $http) ->
  $scope.addReviewSeason = ->
    $scope.reviewSeason =
      start: null
      end: null
      promoStart: null
      promoEnd: null
      repeater: 0.0
      fullReview: 0.0
      doubleReview: 0.0
      coaching: 0.0
      reservation: 0.0
]