var directionsDisplay;
var directionsService = new google.maps.DirectionsService();

function initialize() {
  directionsDisplay = new google.maps.DirectionsRenderer();
  var mapOptions = {
    zoom: 7,
    center: new google.maps.LatLng(41.850033, -87.6500523)
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);
  directionsDisplay.setMap(map);
  directionsDisplay.setPanel(document.getElementById('directions-panel'));

  var control = document.getElementById('control');
  control.style.display = 'block';
  map.controls[google.maps.ControlPosition.TOP_CENTER].push(control);
}

function calcRoute(our_response) {
  var start = document.getElementById("start").value;
  var end = document.getElementById("end").value;
  var request = {
    origin:start,
    destination:end,
    travelMode: google.maps.TravelMode.DRIVING
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    }
  });
}

google.maps.event.addDomListener(window, 'load', initialize);
$.getJSON("http://localhost:3000/api/sub_routes/55.json", function(json) {
  calcRoute(json);
});
$(document).ready();

// function calcRoute(json) {
// //   var start = document.getElementById('start').value;
// //   var end = document.getElementById('end').value;
// //   var request = {
// //       origin:start,
// //       destination:end,
// //       travelMode: google.maps.TravelMode.TRANSIT
// //   };
// // directionsService.route(request, function(response, status) {
// //   if (status == google.maps.DirectionsStatus.OK) {
//     directionsDisplay.setDirections(json);
// //   }
// // });
// }

// google.maps.event.addDomListener(window, 'load', initialize);