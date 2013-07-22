// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function(){
	
	if($('#pd').length > 0){
		
		setTimeout(ideaPoll, 15000);
	}
});




function ideaPoll(){
	//$.get($('#pd').data('url'));
	var updated = false;
	var numIdeas = parseInt($('#num-ideas').html());

	//$.ajax('/peripherals/get_latest'
	$.ajax({  
		type: 'POST', 
		url: '/peripherals/get_latest', 
		data: {'num_ideas' : numIdeas},
    
		success:function(data){
			console.log(data)
			
			
			if(data.data.length > 0){
			
			// reloads page if changes has been made in project database
				window.location.reload(true);
				updated = true;
// old method of changing the content of #pd in js
/*	
				for(var i=0;i<data.data.length;i++){
					if(i==0){
						if(data.data[i].status == 2){
							html=html+"<div class = 'row'><div class='span4 offset4 pd-element'><h2>"+data.data[i].title+"</h2><small>updated: "+data.data[i].updated_at+"</small><small> - by : "+data.data[i].modified_by+"</small><div class='progress'><div class='bar' style='width: "+data.data[i].progress+"%'></div></div></div></div>"
						} else {
							html=html+"<div class = 'row'><div class='span4 offset4 pd-element'><h2>"+data.data[i].title+"</h2><small>updated: "+data.data[i].updated_at+"</small><small> - by : "+data.data[i].modified_by+"</small><div class='progress progress-warning'><div class='bar' style='width: 100%'></div></div></div></div>"					
								}
					}else if(i==1 && data.data.length>2){
						if(data.data[i].status == 2){
							html=html+"<div class = 'row'><div class='span4 offset1 pd-element'><h2>"+data.data[i].title+"</h2><small>updated: "+data.data[i].updated_at+"</small><small> - by : "+data.data[i].modified_by+"</small><div class='progress'><div class='bar' style='width: "+data.data[i].progress+"%'></div></div></div>"
						} else {
							html=html+"<div class = 'row'><div class='span4 offset1 pd-element'><h2>"+data.data[i].title+"</h2><small>updated: "+data.data[i].updated_at+"</small><small> - by : "+data.data[i].modified_by+"</small><div class='progress progress-warning'><div class='bar' style='width: 100%'></div></div></div>"					
								}
					}else if(i==2){
						if(data.data[i].status == 2){
							html=html+"<div class='span4 offset2 pd-element'><h2>"+data.data[i].title+"</h2><small>updated: "+data.data[i].updated_at+"</small><small> - by : "+data.data[i].modified_by+"</small><div class='progress'><div class='bar' style='width: "+data.data[i].progress+"%'></div></div></div></div>"
						} else {
							html=html+"<div class='span4 offset2 pd-element'><h2>"+data.data[i].title+"</h2><small>updated: "+data.data[i].updated_at+"</small><small> - by : "+data.data[i].modified_by+"</small><div class='progress progress-warning'><div class='bar' style='width: 100%'></div></div></div></div>"						}
					}else{
						if(data.data[i].status == 2){
							html=html+"<div class = 'row'><div class='span4 offset4 pd-element'><h2>"+data.data[i].title+"</h2><small>updated: "+data.data[i].updated_at+"</small><small> - by : "+data.data[i].modified_by+"</small><div class='progress'><div class='bar' style='width: "+data.data[i].progress+"%'></div></div></div></div>"
						} else {
							html=html+"<div class = 'row'><div class='span4 offset4 pd-element'><h2>"+data.data[i].title+"</h2><small>updated: "+data.data[i].updated_at+"</small><small> - by : "+data.data[i].modified_by+"</small><div class='progress progress-warning'><div class='bar' style='width: 100%'></div></div></div></div>"					
								}
					}
					
				}			
				$('#pd').html(html)
*/
			}
		},
		error:function(err){
			console.log('error on get request')
		}
	});
	if(updated){
		setTimeout(ideaPoll, 15000);
	} else {
		setTimeout(ideaPoll, 4000);
	}
}
