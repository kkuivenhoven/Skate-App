function new_getLocation() {
				var x = document.getElementById("new_demo");
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    } else { 
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}

function showPosition(position) {
    var x = document.getElementById("new_demo");
		//var y = document.getElementById("skate_spot_latitude");
    //x.innerHTML = "Latitude: " + position.coords.latitude + 
    //"<br>Longitude: " + position.coords.longitude;
		$('input#skate_spot_latitude').val(position.coords.latitude);
		$('input#skate_spot_longitude').val(position.coords.longitude);
}


