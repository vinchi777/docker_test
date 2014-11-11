# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(window).load ->
  coverflow = $('.coverflow')
  coverflow.removeClass('hidden')
  coverflow.coverflow({active: 2})

  config = {
    easing: 'hustle',
    reset:  true,
    delay:  'onload',
    vFactor: 0.90
  }

  window.sr = new scrollReveal(config);

@bindDatePicker = ->
  $('.date-picker').datetimepicker
    pickTime: false

$ ->
  bindDatePicker()

  $('#home .banner').height($(window).height())

  # Change navbar bg color dynamically in home
  if $('#home').length
    anchor = 0
    $(document).scroll ->
      if $(this).scrollTop() > anchor
        $('.header').removeClass('for-home')
      else
        $('.header').addClass('for-home')

  if has_google_map()
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
  else
    $('#map').hide()

    $(window).scroll( ->
      $('#countup:in-viewport(-100)').run(animateCountup)
    )
canAnimate = true
animateCountup = ->
  if canAnimate
    canAnimate = false
    options = { useEasing: true, useGrouping: true,separator: ',', decimal: '.', prefix: '', suffix: ''}
    limit = parseInt($('#countup').data('count'))
    countup = new countUp("countup", 0, limit, 0, 2, options);
    countup.start(finishAnimate);

finishAnimate = ->
  canAnimate = true