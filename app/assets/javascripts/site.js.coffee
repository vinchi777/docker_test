# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  map = new GMaps({
    div: '#map'
    lat: 11.24450
    lng: 124.998627
    zoom: 18
  })

  map.addMarker({
    lat: 11.244554
    lng: 124.998656
    title: 'Maximum Review Center One'
  })

  $('.coverflow').coverflow({active: 4});