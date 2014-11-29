@app = angular.module('maxRevApp', ['ui.bootstrap', 'ngResource']);

@app.factory "Test", ($resource) ->
  $resource "/tests/:id.json"

@app.factory 'Grade', ($resource)  ->
  $resource "/grades/:id.json"

@app.factory 'ReviewSeason', ($resource)  ->
  $resource "/review_seasons/:id.json"

@app.factory 'AnswerSheet', ($resource)  ->
  $resource "/answer_sheets/:id.json"

$ ->
  $('ul.pagination li:first-child a').html '<i class="fa fa-chevron-circle-left"></i>'
  $(' ul.pagination li:nth-child(2) a').html '<i class="fa fa-chevron-left"></i>'
  $(' ul.pagination li:nth-last-child(2) a').html '<i class="fa fa-chevron-right"></i>'
  $(' ul.pagination li:last-child a').html '<i class="fa fa-chevron-circle-right"></i>'