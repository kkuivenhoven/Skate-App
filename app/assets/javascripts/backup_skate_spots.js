/*http://stackoverflow.com/questions/3059044/google-maps-js-api-v3-simple-multiple-marker-example*/
/*function all_coords() {
			//var contents = $('#skate_latlng');
			var skate_coords = document.getElementById('all_latlng').innerHTML;
			coords_size = skate_coords.length;
			var copy_sc = skate_coords;
			var new_sc = copy_sc.slice(1, coords_size-1);
			var coords_split = new_sc.split(",");
			var name = coords_split[0];
			var lat = coords_split[1];
			var lng = coords_split[2];
			//alert(coords_split[0]);
			return [name, lat, lng];
}


function allinitMap() {
				var the_coords = all_coords();
				var copy_coords = the_coords;
				var okay = [];
				var size = 3;
				var okay = the_coords.split(0, 3);
				//var thiis = the_coords.split(0, 3);
				//alert(okay);
				/*while (the_coords.length > 0)
				{
						okay.push(the_coords.splice(0, size));
				}*/
				//alert(thiis);

				//alert(typeof(the_coords));
				/*var lati = parseFloat(the_coords[0]);
				var longi = parseFloat(the_coords[1]);
				var uluru = {lat: lati, lng: longi};
				var map = new google.maps.Map(document.getElementById('map'), {
					zoom: 10,
					center: uluru
				});
				var marker = new google.maps.Marker({
					position: uluru,
					map: map
				});*/
		/*var locations = [
      ['Coogee Beach', -33.923036, 151.259052, 5],
      ['Cronulla Beach', -34.028249, 151.157507, 3],
      ['Manly Beach', -33.80010128657071, 151.28747820854187, 2],
      ['Maroubra Beach', -33.950198, 151.259302, 1]
    ];
			
/*var arrays = []
var size = 3;

while (the_coords.length > 0)
{
    arrays.push(the_coords.splice(0, size));
}*/


    /*var map = new google.maps.Map(document.getElementById('index_map'), {
      zoom: 10,
				center: new google.maps.LatLng(-33.92, 151.25),
      //center: new google.maps.LatLng(the_coords[1], the_coords[2]),
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
}*/

