$(document).ready(function() {
	$(".new_user").hide();
	$(".new_game").hide();
	$('#new_user_button').click(function(){
	    $(".new_user").toggle();
	    $(".new_game").hide();
	    return false;
	 });

	$('#new_game_button').click(function(){
	    $(".new_game").toggle();
	    $(".new_user").hide();
	    return false;
	 });
});