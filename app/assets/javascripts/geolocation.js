var geoLoc = (function() {

  var init = function() {
    var binder = new Binder();
    binder.bind();
  };

  var Binder = function() {};

  Binder.prototype = {
    bind: function() {
      var controller = new Controller();
      this.bindGeolocate(controller);
    },

    bindGeolocate: function(controller) {
      $('#geolocateButton').on('click', function(){
        controller.getLocation();
      });
    }
  }

  var Controller = function() {};

  Controller.prototype = {
    getLocation: function(){
      if ("geolocation" in navigator){
        navigator.geolocation.getCurrentPosition(this.onSuccess, this.showError);
      }
      else {
        alert('Geolocation is not supported in your browser.');
      }
    },

    onSuccess: function(position){
      var coords = position.coords.latitude + "," + position.coords.longitude;
      $("#trip_current_location").val(coords);
    },

    showError: function(error) {
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
  };

  return {
    init: init
  }

})();

$(document).ready(function(){
  geoLoc.init();


})

