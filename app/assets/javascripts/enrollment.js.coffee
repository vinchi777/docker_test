PREV = 1
NEXT = 2

$(document).on 'click', '#enrollment .navigation .btn', ->
  me = $(this)
  mode = if me.hasClass 'previous' then PREV else NEXT
  change_view me, mode

  false


change_view = (element, mode) ->
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

