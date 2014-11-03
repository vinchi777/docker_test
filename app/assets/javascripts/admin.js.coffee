$ ->
  parsePixel = (i) ->
    parseInt(i.slice(0, -2))

  # Fix admin nav height
  header = $('.navbar.header')
  footer = $('footer.admin')
  win = $(window)
  content = $('.admin .admin-content')
  nav = $('.admin-nav')

  if (content.size() != 0)
    contentHeight = parsePixel(content.css('padding-top')) + parsePixel(content.css('padding-bottom')) + content.height()
    height = win.height() - header.height() - footer.height()
    if (contentHeight < height)
      nav.height(height + 5)
    else
      nav.height(contentHeight + 10)