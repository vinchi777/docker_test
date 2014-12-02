@app.controller 'StudentAnswerSheetsCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.sheets = []
  $scope.sheet = {
    remaining: 0
  }

  $scope.load = (id) ->
    r = $http.get '/answer_sheets.json', params:
      student: id
    r.success (d) ->
      $scope.sheets = d
]

@app.controller 'StudentAnswerSheetCtrl', ['$scope', '$http', 'AnswerSheet', ($scope, $http, AnswerSheet) ->
  audioPlayed = false

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

  $scope.$watch (-> $scope.sheet), (v) ->
    if v
      d = new Date(new Date().getTime() + v.remaining * 1000)
      $('#remaining').countdown d, (e) ->
        $scope.$apply ->
          $scope.near = (e.offset.hours * 360 + e.offset.minutes * 60 + e.offset.seconds) <= 300
          if !$scope.sheet.submitted && $scope.near && !audioPlayed
            audioPlayed = true
            new Audio('/assets/countdown.mp3').play()

        if e.offset.hours > 0
          $(this).html e.strftime('%H hr %M min %S sec')
        else if e.offset.minutes > 0
          $(this).html e.strftime('%M min %S sec')
        else
          $(this).html e.strftime('%S sec')

  $scope.submit = ->
    r = $http.patch "/answer_sheets/#{$scope.sheet.id}/submit.json", answer_sheet: $scope.sheet
    r.success (d) ->
      $scope.sheet = d

  $scope.moment = (i) ->
    moment(i).fromNow()
]