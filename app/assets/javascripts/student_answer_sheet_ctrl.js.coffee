@app.controller 'StudentAnswerSheetsCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.ongoing = []
  $scope.answerSheets = []

  $scope.load = (id) ->
    r = $http.get '/answer_sheets.json', params:
      student: id
    r.success (d) ->
      $scope.answerSheets = d
      $scope.ongoing = (s for s in d when !s.submitted)
]

@app.controller 'StudentAnswerSheetCtrl', ['$scope', '$http', 'AnswerSheet', ($scope, $http, AnswerSheet) ->
  $scope.load = (id) ->
    AnswerSheet.get id: id, (s) ->
      $scope.sheet = s

  $scope.update = ->
    $scope.saving = true
    r = $http.patch "/answer_sheets/#{$scope.sheet.id}.json", answer_sheet: $scope.sheet
    r.success (d) ->
      $scope.saving = false
      $scope.sheet = d
    r.error (e) ->
      $scope.saving = false

  $scope.remaining = ->
    if $scope.sheet && $scope.sheet.test.timer > 0
      r = $scope.sheet.test.timer - ($scope.sheet.elapsed / 60)
      m = parseInt r
      s = parseInt((r - m) * 60)
      "#{m}:#{s}"

  $scope.submit = ->
    r = $http.patch "/answer_sheets/#{$scope.sheet.id}/submit.json", answer_sheet: $scope.sheet
    r.success (d) ->
      $scope.sheet = d
]