function loadJSON()
{

  var post_file = "/trips"
  // var get_file = "/trips/{tripId}"
  if (window.XMLHttpRequest) {// IE7+, Firefox, Chrome, Opera, Safari
    http_request = new XMLHttpRequest();
  }
  else { // IE6, IE5
    http_request = new ActiveXObject("Microsoft.XMLHTTP");
  }
  http_request.onreadystatechange = function() {
    if (http_request.readyState == 4 && http_request.status == 200) {
      document.getElementById("map-canvas").innerHTML=http_request.responseText;
    }
  }
  http_request.open("POST", post_file, true);
  http_request.send();
  // http_request.open("GET", get_file, true);
  // http_request.send();
  return false;
};
$('#button').click(loadJSON());




// http://www.tutorialspoint.com/json/json_ajax_example.htm
// http://www.w3schools.com/ajax/tryit.asp?filename=tryajax_first