console.log("I am in map.js");

var directionsService = new google.maps.DirectionsService();
var map;
var geocoder;

function initialize() {
 geocoder = new google.maps.Geocoder();
 var newYork = new google.maps.LatLng(41.850033, -73.6500523);
 var mapOptions = {
   zoom:7,
   center: newYork
 }
 map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
 console.log("I have set the map");
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