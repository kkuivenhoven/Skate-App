/**
	* Sources/Inspiration: 
	*		• http://josephndungu.com/tutorials/gmail-like-chat-application-in-ruby-on-rails
	* 
	* The various stackoverflow posts and API pages I used to help get a deeper understanding
	* of the jQuery and methods implemented by Joseph Ndungu in his tutorial so that I could
	* write a "my own" version that was inspired by Joseph Ndungu.
	* 	• https://api.jquery.com/jquery.post/
	* 	• https://stackoverflow.com/questions/3407133/how-do-i-get-the-scroll-position-of-a-document
	*		• https://stackoverflow.com/questions/270612/scroll-to-bottom-of-div
	*		• https://www.w3schools.com/jquery/css_scrolltop.asp
	*		• https://www.sitepoint.com/jqueryhtml5-input-focus-cursor-positions/
	* 			(referenced for positioning cursor in input textbox)
	*		• http://www.javascripter.net/faq/trim.htm
	* 			(for removing trailing and leading spaces in a string)
	*		• https://stackoverflow.com/questions/1193405/jquery-toggle-and-if-visible
	* 			(for slideToggle() callback for textarea focus when header is clicked)
	*	• https://stackoverflow.com/questions/10284597/get-count-of-child-elements-from-one-instance-of-a-class
	* 			(for getting child elements)
	*
	*/

var chatboxFocus = new Array();
var chatBoxes = new Array();

var ready = function () {

	var convID;
	var numChats;

	$(document).on('click', '.start-conversation', function (e) {
		e.preventDefault();
		var senderID = $(this).data('sid');
		var recipientID = $(this).data('rip');
		$.post("/conversations", { sender_id: senderID, recipient_id: recipientID }, function (response) {
				convID = response.conversation_id;
				$("body").append('<div id="chatbox_' + response.conversation_id + '" class="chatbox"></div>');	
				$.get("/conversations/" + response.conversation_id, {}, function (data) {
					$('#chatbox_' + response.conversation_id).html(data);
					// the below line "...sets the vertical position of the scrollbar for ALL matched elements" (w3schools)
					$('#chatbox_' + convID + ' .chatboxcontent').scrollTop($('#chatbox_' + convID + ' .chatboxcontent')[0].scrollHeight);
					$('.chatboxtextarea').focus();
				}, "html");
				$('#chatbox_' + response.conversation_id).css('bottom', '0px');
				$('#chatbox_' + response.conversation_id).css('right', '20px');
				$('#chatbox_' + response.conversation_id).css('display', 'block');
				if($('.chatbox').length == 1){
					numChats = 1;
				}
				else{
					numChats++;
					restructure();
				}
		});
	});


	function restructure(){
		var allChats = $('.chatbox:visible');
		allChats.each(function(index, elem){
			var moveOver = (index) * (280 + 7) + 20;
			$('#' + elem.id).css('right', moveOver + 'px');
		});
	}


	$(document).on('click', '.closeChat', function (e) { 
		e.preventDefault();
		$('#chatbox_' + $(this).data('cid')).css('display', 'none');
		$('.chatboxtextarea').focusout();
		if(numChats != 1){
			restructure();
		}
		numChats--;
	});


	$(document).on('click', '.chatboxhead', function (e) {
		e.preventDefault();
		$('#chatbox_' + $(this).data('cid') + " .chatboxcontent").slideToggle(300, 'swing');
		$('#chatbox_' + $(this).data('cid') + " .chatboxinput").slideToggle(300, 'swing', function(){
				if($(this).css('display') == "none"){
					//$('.chatboxtextarea').focusout();
				}
				else{
					//$('.chatboxtextarea').focus();
					$(this).children().children()[2].focus();
				}
		});
		$('#chatbox_' + $(this).data('cid') + ' .chatboxcontent').scrollTop($('#chatbox_' + $(this).data('cid') + ' .chatboxcontent')[0].scrollHeight);
	});



	$(document).on('keydown', '.chatboxtextarea', function(e) {
		var id = $(this).data('cid');
		if(e.keyCode == 13){ // had to change e.which to e.keyCode, 
												 // o.w. e.preventDefault() would prevent user from typing input
			e.preventDefault(); 
			//var mensaje = $('.chatboxtextarea').val();
			var mensaje = $(this).val();
			// need to use /^\s+|\s+$/g to replace/remove trailing ^ leading spaces in mensaje 
			mensaje = mensaje.replace(/^\s+|\s+$/g, "");
			if(mensaje != ''){
				$('#conversation_form_' + id).submit();
				//$('.chatboxtextarea').val('');
				//$('.chatboxtextarea').focus();
				$(this).val('');
				$(this).focus();
			}
		}
	});

}


$(document).ready(ready);
$(document).on("page:load", ready);

