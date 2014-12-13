@app = angular.module('maxRevApp', ['ui.bootstrap']);

# Extracted from Morph https://github.com/cmoncrief/morph
@capFirst = (input) ->
  "#{input[0].toUpperCase()}#{input.slice 1}"

# Extracted from Morph https://github.com/cmoncrief/morph
@toHuman = (input, cap = true) =>
  output = input.replace /[-._]/g, ' '
  output = output.replace /([A-Z\d])([A-Z][a-z\d])/g, '$1 $2'
  output = output.replace /([a-z])([A-Z])/g, '$1 $2'
  output = output.replace /(\s([a-zA-Z])\s)/g, (str, p1) -> "#{p1.toLowerCase()}"
  output = output.replace /([A-Z])([a-z])/g, (str, p1, p2) -> "#{p1.toLowerCase()}#{p2}"
  output = if cap then capFirst output else lowerFirst output
  return output

$ ->
  $('ul.pagination li:first-child a').html '<i class="fa fa-chevron-circle-left"></i>'
  $('ul.pagination li:nth-child(2) a').html '<i class="fa fa-chevron-left"></i>'
  $('ul.pagination li:nth-last-child(2) a').html '<i class="fa fa-chevron-right"></i>'
  $('ul.pagination li:last-child a').html '<i class="fa fa-chevron-circle-right"></i>'