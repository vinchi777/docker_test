@app.controller 'StudentAnswerSheetsCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.sheets = []

  $scope.load = (id) ->
    r = $http.get '/answer_sheets.json', params:
      student: id
    r.success (d) ->
      $scope.sheets = d
]

@app.controller 'StudentAnswerSheetCtrl', ['$scope', '$http', '$timeout', ($scope, $http, $timeout) ->
  $scope.sheet = {
    remaining: 0
    answers: []
  }

  updateOnZero = false
  audioPlayed = false

  $scope.load = (id) ->
    r = $http.get "/answer_sheets/#{id}.json"
    r.success (s) ->
      $scope.sheet = s
      updateTimer()

  $scope.update = ->
    $scope.saving = true
    r = $http.patch "/answer_sheets/#{$scope.sheet.id}.json", answer_sheet: $scope.sheet
    r.success (d) ->
      $scope.saving = false
      $scope.sheet = d
      updateTimer()

    r.error (e) ->
      $scope.saving = false

  $scope.done = ->
    a for a in $scope.sheet.answers when a.index != null

  updateTimer = ->
    if $scope.sheet
      d = new Date(new Date().getTime() + $scope.sheet.remaining * 1000)
      $('#remaining').countdown d, (e) ->
        $timeout ->
          $scope.near = remaining(e) <= 300
          if !updateOnZero && remaining(e) <= 0
            updateOnZero = true
            $scope.update()

        if !$scope.sheet.submitted && $scope.near && !audioPlayed && $scope.sheet.test.timer > 0
          audioPlayed = true
          new Audio('/assets/countdown.mp3').play()

        if e.offset.hours > 0
          $(this).html e.strftime('%H hr %M min %S sec')
        else if e.offset.minutes > 0
          $(this).html e.strftime('%M min %S sec')
        else
          $(this).html e.strftime('%S sec')

  remaining = (e) ->
    e.offset.hours * 360 + e.offset.minutes * 60 + e.offset.seconds

  $scope.submit = ->
    r = $http.patch "/answer_sheets/#{$scope.sheet.id}/submit.json", answer_sheet: $scope.sheet
    r.success (d) ->
      $scope.sheet = d
      updateTimer()

  $scope.moment = (i) ->
    moment(i).fromNow()
]