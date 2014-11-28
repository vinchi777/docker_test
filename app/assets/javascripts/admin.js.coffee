@app = angular.module('maxRevApp', ['ui.bootstrap']);

$ ->
  $('ul.pagination li:first-child a').html '<i class="fa fa-chevron-circle-left"></i>'
  $(' ul.pagination li:nth-child(2) a').html '<i class="fa fa-chevron-left"></i>'
  $(' ul.pagination li:nth-last-child(2) a').html '<i class="fa fa-chevron-right"></i>'
  $(' ul.pagination li:last-child a').html '<i class="fa fa-chevron-circle-right"></i>'