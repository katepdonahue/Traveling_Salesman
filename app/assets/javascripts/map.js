var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var map;
var geocoder;

function initialize() {
 directionsDisplay = new google.maps.DirectionsRenderer();
 directionsDisplay1 = new google.maps.DirectionsRenderer();
 directionsDisplay2 = new google.maps.DirectionsRenderer();
 geocoder = new google.maps.Geocoder();
 var chicago = new google.maps.LatLng(41.850033, -87.6500523);
 var mapOptions = {
   zoom:7,
   center: chicago
 }
 map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
 directionsDisplay.setMap(map);
}

function addMarker(address) {
  // var addresses = document.getElementsByClassName("waypoints");
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      alert("Geocode was not successful for the following reason: " + status);
    }
  });
}


google.maps.event.addDomListener(window, 'load', initialize);