function all_coords(){var e=document.getElementById("all_latlng").innerHTML;coords_size=e.length;var n=e,o=n.slice(1,coords_size-1),t=o.split(",");return t}function allinitMap(){for(var e=all_coords(),n=e,o=$.map(n,function(e,n){return[e]}),t=[],a=3;o.length>0;)t.push(o.splice(0,a));var l,g=[];for(l=0;l<t.length;l++)g.push(t[l]);var r,l,p=new google.maps.Map(document.getElementById("index_map"),{zoom:6,center:new google.maps.LatLng(n[1],n[2]),mapTypeId:google.maps.MapTypeId.ROADMAP}),s=new google.maps.InfoWindow;for(l=0;l<g.length;l++)r=new google.maps.Marker({position:new google.maps.LatLng(g[l][1],g[l][2]),map:p}),google.maps.event.addListener(r,"click",function(e,n){return function(){s.setContent(g[n][0]),s.open(p,e)}}(r,l))}