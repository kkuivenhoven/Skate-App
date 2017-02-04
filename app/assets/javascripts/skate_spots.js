// Initialize the plugin.
//$("input").geocomplete({ map: ".map_canvas" });

// Call the find method with the parameter "NYC".
//$("input").geocomplete("find", "NYC");

// Get the map and set a new zoom level.
//var map = $("input").geocomplete("map");
//map.setZoom(3);



handler = Gmaps.build('Google');
handler.buildMap({ internal: {id: 'basic_map' }});
