$ ->
  $('.course-outline li a').mouseover (e) ->
    id = $(this).attr('href')
    $(id).addClass 'active'

  $('.course-outline li a').mouseout (e) ->
    id = $(this).attr('href')
    $(id).removeClass 'active'