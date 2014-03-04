
$(document).ready(function() {
  $("input[type=submit]").before($(".fields")[1]);
});

var directionsService = new google.maps.DirectionsService();
var directionsService2 = new google.maps.DirectionsService();
var map;
var geocoder;

function initialize() {
 geocoder = new google.maps.Geocoder();
 var newYork = new google.maps.LatLng(40.6973327, -73.9860515);
 var mapOptions = {
   zoom:12,
   center: newYork
 }
 map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
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