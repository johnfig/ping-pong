$(document).ready(function() {
	$(".new_user").hide();
	$(".new_game").hide();
	$('#new_user_button').click(function(){
	    $(".new_user").toggle();
	    return false;
	 });

	$('#new_game_button').click(function(){
	    $(".new_game").toggle();
	    return false;
	 });
});