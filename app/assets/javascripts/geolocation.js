form_addres = document.querySelectorAll('.demo')

function getLocation(){
  if ("geolocation" in navigator){
    navigator.geolocation.getCurrentPosition(onSuccess, showError){
    })
  }
  else {
    // User is going to have to input location themselves
    alert('Geolocation is not supported in your browser.')
  }
}

function onSuccess(position){
  alert("Your lat, long: " + position.coords.latitude + ", " + position.coords.longitude)

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

document.addEventListener('DOMContentLoaded', function(){



})

// getLocation()