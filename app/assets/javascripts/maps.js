function getcoords() {
			//var contents = $('#skate_latlng');
			var skate_coords = document.getElementById('skate_latlng').innerHTML;
			coords_size = skate_coords.length;
			var copy_sc = skate_coords;
			var new_sc = copy_sc.slice(1, coords_size-1);
			var coords_split = new_sc.split(",");
			var lat = coords_split[0];
			var lng = coords_split[1];
			//alert(coords_split[0]);
			return [lat, lng];
}


function ind_initMap() {
				var the_coords = getcoords();
				var lati = parseFloat(the_coords[0]);
				var longi = parseFloat(the_coords[1]);
				var uluru = {lat: lati, lng: longi};
				var map = new google.maps.Map(document.getElementById('show_map'), {
					zoom: 10,
					center: uluru
				});

 // Try HTML5 geolocation.
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
              lat: position.coords.latitude,
              lng: position.coords.longitude
            };

            infoWindow.setPosition(pos);
            infoWindow.setContent('Location found.');
            infoWindow.open(map);
            map.setCenter(pos);
          }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
          });
        } else {
          // Browser doesn't support Geolocation
          handleLocationError(false, infoWindow, map.getCenter());
        }




				var marker = new google.maps.Marker({
					position: uluru,
					map: map
				});
}


 function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                              'Error: The Geolocation service failed.' :
                              'Error: Your browser doesn\'t support geolocation.');
        infoWindow.open(map);
      }
