class PeripheralsController < ApplicationController
  	
	layout 'pd_display'

# Checks database for updated entries. if there are some, it sends a json request to a jqeury/ajax listener to reload page    

	def get_latest
		
		if (Post.where('updated_at > ?', Time.now - 15.seconds).length > 0)
			
			@lasttwo = Post.limit(3).order('updated_at desc')
			render :json => { :data => @lasttwo }
		else
			
			render :json => { :data => {} }
		end
	end
	
	
	def display

		
		@posts = Post.all
		@lasttwo = Post.limit(3).order('updated_at desc')

	end


end
