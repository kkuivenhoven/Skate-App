$( document ).ready(function() {
	var tour;
	var user_logged_in = $('meta[name=logged_in_user]').attr("content");
	if(user_logged_in == "true"){
		if(tour == null){
			tour = new Tour({
				//storage: false,
				steps: [
					{
						element: $('#main_nav'),
						title: "Main navigation links",
						content: "This navigation bar contains regular links and dropdowns with more links. If there is an upside down triangle on the right side of the phrase, click the upside down triangle for more information!",
						placement: "bottom"
					},
					{
						element: $('#UO_nav'),
						title: "User options",
						content: "Links to your profile, settings, other users profiles, and the log out link!",
						placement: "bottom"
					},
					{
						element: $('#SS_nav'),
						title: "Skate spot options",
						content: "Links to all the skate spots! You can add your own skate spots through the new skate spot links - and can create based on your physical GPS location or by address!",
						placement: "bottom"
					},
					{
						element: $('#RO_nav'),
						title: "Rating options",
						content: "View all skate spots that have been rated along with their average ratings! Sorting option to available for finding toughest ratest spots with the least security and more!",
						placement: "bottom"
					},
					{
						element: $('#EO_nav'),
						title: "Event options",
						content: "View all events that are occuring in the future at documented skate spots!",
						placement: "bottom"
					},
					{
						element: $('#Res_nav'),
						title: "Resources",
						content: "Links to various skateboarding social media organizations!",
						placement: "bottom"
					}
				]
			});	

			tour.init();
			tour.start();
		}
		else{
			if(tour.ended()){
				tour.restart();
			}
		}
	}
});

