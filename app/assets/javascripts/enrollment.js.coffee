PREV = 1
NEXT = 2

###$(document).on 'click', '#enrollment .navigation .btn', ->
  me = $(this)
  mode = if me.hasClass 'previous' then PREV else NEXT
  change_view me, mode

  false###
$(document).on 'click', '#enrollment .trigger-file-field', ->
  $(this).parent().find('input:file').click()
  false


change_view = (element, mode) ->
  # update views
  current = $('#enrollment .steps > .active')
  description = $('#enrollment .description')
  next = if mode == PREV then current.prev() else current.next()

  if next.length
    current.removeClass 'active'
    next.addClass 'active'
    description.text next.data('desc')
    do_scroll()
  else
    window.location = '/'

  # update indicators
  last = $('#enrollment .indicator.active').last()

  if mode == PREV
    last.removeClass 'active'
  else
    last.next().addClass 'active'

  # update buttons
  next = if mode == PREV then next.prev() else next.next()
  prev_btn = $('#enrollment .navigation .previous')
  next_btn = $('#enrollment .navigation .next')

  if next.length
    prev_btn.text('Back')
    next_btn.text('Next')
  else
    if mode == PREV
      prev_btn.text('Cancel')
    else
      next_btn.text('Done')

  if description.text() == 'Payment'
    $('#enrollment .paypal').removeClass 'hidden'
    next_btn.text('Skip')
  else
    $('#enrollment .paypal').addClass('hidden')


