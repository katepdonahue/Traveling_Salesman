var directionsDisplay;
var directionsService = new google.maps.DirectionsService();

function initialize() {
  directionsDisplay = new google.maps.DirectionsRenderer();
  var mapOptions = {
    zoom: 7,
    center: new google.maps.LatLng(40.850033, -70.23)
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);
  directionsDisplay.setMap(map);
  directionsDisplay.setPanel(document.getElementById('directions-panel'));
}

function calcRoute(response) {
      directionsDisplay.setDirections(response);
}

google.maps.event.addDomListener(window, 'load', initialize);

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
