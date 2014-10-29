$ ->
  # Fix admin nav height
  header = $('.navbar.header')
  footer = $('footer.admin')
  win = $(window)
  content = $('.admin .admin-content')
  nav = $('.admin-nav')

  height = win.height() - header.height() - footer.height() - 20
  if (content.height() < height)
    nav.height(height)
  else
    nav.height(content.height())