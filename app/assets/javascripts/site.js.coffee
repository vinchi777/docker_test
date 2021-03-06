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

  # $('body').on 'DOMNodeInserted', ->
  #svg-injector
  mySVGsToInject = document.querySelectorAll('img.inject-me:not(.injected-svg)')
  SVGInjector(mySVGsToInject)

  #datepicker
  $('body').find('.date-picker:not(.picked)').each ->
    self = $(this)
    unless self.hasClass('picked')
      self.addClass 'picked'
      self.datetimepicker
        pickTime: false

  #momentjs
  $('body').find('.moment:not(.momented)').each ->
    self = $(this)
    unless self.hasClass('momented')
      self.addClass('momented')
      date = self.text()
      m = moment(date).format('MMMM D');
      self.text(m)

  #scrollreveal
  window.sr = new scrollReveal();

  #count animation in homepage
  $(window).scroll(->
    $('#countup:in-viewport(-100)').run(animateCountup)
  )
  countDone = false
  animateCountup = ->
    unless countDone
      countDone = true
      options = {useEasing: true, useGrouping: true, separator: ',', decimal: '.', prefix: '', suffix: ''}
      limit = parseInt($('#countup').data('count'))
      countup = new countUp("countup", 0, limit, 0, 10, options);
      countup.start();


  $('.footer .share .facebook').click ->
    href = $(this).attr('href')
    window.open(href,'sharer', windowFeatures());
    false

  $('.footer .share .twitter').click ->
    href = $(this).attr('href')
    url = encodeURI(href+"?text=Settle for nothing less but the best.")
    window.open(url,'sharer', windowFeatures());
    false

  windowFeatures = ->
    width = 550
    height = 350
    left = (window.screen.width / 2) - ((width / 2) + 10)
    top = (window.screen.height / 2) - ((height / 2) + 50)
    "status=no,height=" + height + ",width=" + width + ",resizable=yes,left=" + left + ",top=" + top + ",screenX=" + left + ",screenY=" + top + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no"
    

