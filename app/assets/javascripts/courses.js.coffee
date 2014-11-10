$ ->
  $('.course-outline li a').mouseover (e) ->
    id = $(this).attr('href')
    $(id).addClass 'active'

  $('.course-outline li a').mouseout (e) ->
    id = $(this).attr('href')
    $(id).removeClass 'active'

  $('a[data-toggle=tab]').click (e) ->
    do_scroll($($(this).attr 'href'))