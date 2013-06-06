# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

`$(function(){
	if($('#pd').length > 0){
		setTimeout(ideaPoll, 4000);
	}
});

function ideaPoll(){
	$.get($('#pd').data('url'));
	
	setTimeout(ideaPoll, 4000);

}
`