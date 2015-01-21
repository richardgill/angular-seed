window.initialize = ->
  mapOptions =
    zoom: 8
    center: new google.maps.LatLng(-34.397, 150.644)

  map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)
  return

loadScript = ->
  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&" + "callback=initialize"
  document.body.appendChild script
  return


$(window).load ->

loadScript() 