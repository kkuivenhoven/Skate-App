/*http://stackoverflow.com/questions/3059044/google-maps-js-api-v3-simple-multiple-marker-example*/

function all_coords() {
			var skate_coords = document.getElementById('all_latlng').innerHTML;
			coords_size = skate_coords.length;
			var copy_sc = skate_coords;
			var new_sc = copy_sc.slice(1, coords_size-1);
			var coords_split = new_sc.split(",");
			return coords_split;
}


function allinitMap() {
    var the_coords = all_coords();
    var copy_coords = the_coords;
		var coords_array = $.map(copy_coords, function(value, index) {
						    return [value];
		});
		var arrays = [], size = 3;

		while (coords_array.length > 0)
		{
						    arrays.push(coords_array.splice(0, size));
		}

		var locations = [];
		var i;
		for(i=0; i<arrays.length; i++)
		{
				locations.push(arrays[i]);
		}
			
    var map = new google.maps.Map(document.getElementById('index_map'), {
      zoom: 6,
				center: new google.maps.LatLng(copy_coords[1], copy_coords[2]),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });

    var infowindow = new google.maps.InfoWindow();

    var marker, i;

    for (i = 0; i < locations.length; i++) {  
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(locations[i][1], locations[i][2]),
        map: map
      });

      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infowindow.setContent(locations[i][0]);
          infowindow.open(map, marker);
        }
      })(marker, i));
    }
}

