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

function indall_coords() {
			var skate_coords = document.getElementById('show_latlng').innerHTML;
			coords_size = skate_coords.length;
			var copy_sc = skate_coords;
			var new_sc = copy_sc.slice(1, coords_size-1);
			var coords_split = new_sc.split(",");
			return coords_split;
}


function ind_initMap() {
				var the_coords = getcoords();
				var ind_coords = indall_coords();
				var copy_ind = ind_coords;
				//alert(ind_coords);
				var ind_array = $.map(ind_coords, function(value, index) {
						  		return [value];
				});
				var arrays = [], size = 3;
				while(ind_array.length > 0)
				{
						  arrays.push(ind_array.splice(0, size));
				}
				var locations = [];
				var i;
				for(i=0; i<arrays.length; i++)
				{
						  locations.push(arrays[i]);
			   }
				var lati = parseFloat(the_coords[0]);
				var longi = parseFloat(the_coords[1]);
				var uluru = {lat: lati, lng: longi};
				var map = new google.maps.Map(document.getElementById('show_map'), {
					zoom: 10,
					center: uluru,
				   mapTypeId: google.maps.MapTypeId.ROADMAP
				});

				var infowindow = new google.maps.InfoWindow();

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

				/*var marker = new google.maps.Marker({
					position: uluru,
					map: map
				});*/

		  var ind_marker = new google.maps.Marker({
				position: {lat: lati, lng: longi},
				map: map,
				icon: 'https://www.google.com/mapfiles/arrow.png'
			 });

    var marker, i;

    for (i = 1; i < locations.length; i++) {   
			  marker = new google.maps.Marker({
			 position: new google.maps.LatLng(locations[i][1], locations[i][2]),
				 map: map 
       /*if(i == 0){
				  marker = new google.maps.Marker({
					 position: new google.maps.LatLng(locations[i][1], locations[i][2]),
					 map: map,
					icon: 'http://maps.google.com/mapfiles/arrowie.png'
		}*/
    }); 

      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infowindow.setContent(locations[i][0]);
          infowindow.open(map, marker);
        }   
      })(marker, i));
    }  
}


 function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
                              'Error: The Geolocation service failed.' :
                              'Error: Your browser doesn\'t support geolocation.');
        infoWindow.open(map);
      }
