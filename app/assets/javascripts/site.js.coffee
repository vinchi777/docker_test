# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@bindDatePicker = ->
  $('.date-picker').datetimepicker
    pickTime: false

  $('.datetime-picker').datetimepicker()

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

  $(window).scroll(->
    $('#countup:in-viewport(-100)').run(animateCountup)
  )

  mySVGsToInject = document.querySelectorAll('img.inject-me');
  SVGInjector(mySVGsToInject);

  countDone = false
  animateCountup = ->
    unless countDone
      countDone = true
      options = {useEasing: true, useGrouping: true, separator: ',', decimal: '.', prefix: '', suffix: ''}
      limit = parseInt($('#countup').data('count'))
      countup = new countUp("countup", 0, limit, 0, 10, options);
      countup.start();

$(window).load ->
  config = {
    easing: 'hustle',
    reset: false,
    delay: 'once',
    vFactor: 0.90,
  }

  window.sr = new scrollReveal(config);