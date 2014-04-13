form_addres = document.querySelectorAll('.demo')

function getLocation(){
  if ("geolocation" in navigator){
    navigator.geolocation.getCurrentPosition(onSuccess, showError)
  }
  else {
    alert('Geolocation is not supported in your browser.')
  }
}

function onSuccess(position){
  var coords = position.coords.latitude + "," + position.coords.longitude;
  $("#trip_current_location").val(coords);
}

function showError(error) {
    switch(error.code) {
        case error.PERMISSION_DENIED:
            alert("User denied the request for Geolocation.");
            break;
        case error.POSITION_UNAVAILABLE:
            alert("Location information is unavailable.");
            break;
        case error.TIMEOUT:
            alert("The request to get user location timed out.");
            break;
        case error.UNKNOWN_ERROR:
            alert("An unknown error occurred.");
            break;
    }
}

$(document).ready(function(){

  $('#geolocateButton').on('click', function(){
      getLocation();
  })

})

