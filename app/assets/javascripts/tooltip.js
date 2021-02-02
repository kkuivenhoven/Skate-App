window.onload = function(){
	var first = 0;
	var pathname = window.location.pathname;	// returns path only
	var logged_in = $('meta[name=logged_in_user]').attr("content");
	if(logged_in == "false"){
		if((pathname == "/skate_spots") || (pathname == "/ratings/index") || ((pathname.search("/skate_spots")) == 0 ) || (pathname == "/events/index") || (pathname =="/static_pages/skate_links")){
			$(window).scroll(function() {
				var docSize = $(document).height();
				var winSize = $(window).height();
				var half_ds = docSize/4;
				var winScrl = $(window).scrollTop();
				/*
				if(first != 1){
					if((winScrl+winSize) >= (3*half_ds)){
							$('#preventModal').modal('show');
							$(document.body).children('div').children('div').addClass("is-blurred");
							$(document.body).children('div').children('div').last().removeClass("is-blurred");
							first = 1;
					}
				}
				$('#close_PM').click(function() {
					$(document.body).children('div').children('div').removeClass("is-blurred");
						first = 0;
				});
				*/
			});
		}
	}
}

$(document).ready(function(){
			$('[data-toggle="tooltip"]').tooltip(); 
});
