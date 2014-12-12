window.has_google_map = ->
  typeof window.google == 'object' && window.google.maps

$ ->
  #map at home page
  if $('#map').length
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