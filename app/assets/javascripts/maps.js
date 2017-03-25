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


function initMap() {
				var the_coords = getcoords();
				var lati = parseFloat(the_coords[0]);
				var longi = parseFloat(the_coords[1]);
				var uluru = {lat: lati, lng: longi};
				var map = new google.maps.Map(document.getElementById('map'), {
					zoom: 10,
					center: uluru
				});
				var marker = new google.maps.Marker({
					position: uluru,
					map: map
				});
}
