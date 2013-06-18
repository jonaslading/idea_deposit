// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function(){
	if($('#pd').length > 0){
		setTimeout(ideaPoll, 4000);
	}
});

function ideaPoll(){
	//$.get($('#pd').data('url'));
	
	$.ajax('/peripherals/get_last_two',{
		success:function(data){
			console.log(data)
			var html='';
			
			if(data.data.length > 0){
				for(var i=0;i<data.data.length;i++){
					html=html+"<div class = 'row'><div class='span4 offset4 pd-element'><h2>"+data.data[i].title+"</h2><small>updated: "+data.data[i].updated_at+"</small><small> - by : "+data.data[i].modified_by+"</small><div class='progress'><div class='bar' style='width: "+data.data[i].progress+"%'></div></div></div></div>"
					
				}			
				$('#pd').html(html)
			}
		},
		error:function(err){
			console.log('error on get request')
		}
	})
	
	setTimeout(ideaPoll, 4000);

}
