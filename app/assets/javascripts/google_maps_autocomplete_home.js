$(document).ready(function() {
  var location = $('#location_location').get(0);
  var fullAddress;

  if (location) {
    var autocomplete = new google.maps.places.Autocomplete(location, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    // google.maps.event.addListener(autocomplete, 'place_changed', storeAddress);
    google.maps.event.addDomListener(location, 'keydown', function(e) {
      if (e.keyCode === 13 & e.isTrusted === true) {
        e.preventDefault();
      }
    });
  }
});

function onPlaceChanged() {
  var place = this.getPlace();
  var components = getAddressComponents(place);
};

// function storeAddress() {
//   var place = this.getPlace();
//   var addressComponents = getAddressComponents(place);
//   var addressString = JSON.stringify(addressComponents);
//   sessionStorage.setItem('address', addressString);
// };


function getAddressComponents(place) {
  var street_number = null;
  var route = null;
  var zip_code = null;
  var city = null;
  var country_code = null;
  for (var i in place.address_components) {
    var component = place.address_components[i];
    for (var j in component.types) {
      var type = component.types[j];
      if (type == 'locality') {
        locality = component.long_name;
      } else if (type == 'route') {
        route = component.long_name;
      } else if (type == 'postal_code') {
        zip_code = component.long_name;
      } else if (type == 'locality') {
        city = component.long_name;
      } else if (type == 'country') {
        country_code = component.short_name;
      }
    }
  }

  return {
    address: street_number == null ? route : (street_number + ' ' + route),
    zip_code: zip_code,
    city: city,
    country_code: country_code
  };
}
