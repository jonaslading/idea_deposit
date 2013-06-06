// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function(){
	
	 $( "#slider" ).slider({
        min: 0,
        max: 100,
        step: 5,
        slide: function( event, ui ) {
            $( "#amount" ).val( ui.value );
        },

        change: function(event, ui) {
	        $('input#post_progress').val(ui.value);
	    }
    });
/*
    $( "#slider" ).slider({
        value: $('input#post_progress').val(),
    });
*/
	$('#slider').hide();
	$('#post_status').hide();
	
	$("input[name='post[title]']").bind('change', function(){
		$('#post_status').show();
	});
	
	//eventlistner virker ikke
	$("input[name='post[status]']").bind('change', function(){
		$('#slider').show();
	});
});
