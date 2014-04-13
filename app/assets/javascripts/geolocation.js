form_addres = document.querySelectorAll('.demo')

function getLocation(){
  if ("geolocation" in navigator){
    navigator.geolocation.getCurrentPosition(function(position){
      x[0].innerHTML = "Your lat, long: " + position.coords.latitude + ", " + position.coords.longitude
    })
  }
  else {
    // User is going to have to input location themselves
  }
}

getLocation()