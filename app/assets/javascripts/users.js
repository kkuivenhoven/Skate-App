// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

/*var textArea = document.getElementById('aboutMeField');

		var oktest = document.getElementById('user_about_me');

//$(document).ready(function() {
	//alert("this is textArea: " + textArea);
	function checkInput(){
		var test = document.getElementById('user_about_me');
			alert("before its over 180");
			alert("test.innerHTML: " + test.innerHTML);
		if(test.innerHTML.length > 180){
			alert("its over 180");
		}
	

	}

//}); 


$(document).ready(function() {
	$('user_about_me').keypress(function() {
			var dInput = this.value;
			alert(dInput);
			//$(".dDimension:contains('" + dInput + "')").css("display","block");
	}); 
});*/


var ready = function () {
	
    /**
     * When the send message link on our home page is clicked
     * send an ajax request to our rails app with the sender_id and
     * recipient_id
     */

    $('.start-conversation').click(function (e) {
        e.preventDefault();

        var sender_id = $(this).data('sid');
        var recipient_id = $(this).data('rip');

        $.post("/conversations", { sender_id: sender_id, recipient_id: recipient_id }, function (data) {
            chatBox.chatWith(data.conversation_id);
        });
    });

    /**
     * Used to minimize the chatbox
     */

    $(document).on('click', '.toggleChatBox', function (e) {
        e.preventDefault();

        var id = $(this).data('cid');
        chatBox.toggleChatBoxGrowth(id);
    });

    /**
     * Used to close the chatbox
     */

    $(document).on('click', '.closeChat', function (e) {
        e.preventDefault();

        var id = $(this).data('cid');
        chatBox.close(id);
    });

/* https://codepen.io/mehmetmert/pen/zbKpv?editors=1010 */
		$(document).on('click', '.chatboxhead', function (e) {
				e.preventDefault();
        var id = $(this).data('cid');
        chatBox.animCollapse(id);
    });


    /**
     * Listen on keypress' in our chat textarea and call the
     * chatInputKey in chat.js for inspection
     */

    $(document).on('keydown', '.chatboxtextarea', function (event) {

        var id = $(this).data('cid');
        chatBox.checkInputKey(event, $(this), id);
    });

    /**
     * When a conversation link is clicked show up the respective
     * conversation chatbox
     */

    $('a.conversation').click(function (e) {
        e.preventDefault();

        var conversation_id = $(this).data('cid');
        chatBox.chatWith(conversation_id);
    });


}

$(document).ready(ready);
$(document).on("page:load", ready);


