class PeripheralsController < ApplicationController
  	


# Checks database for updated entries. if there are some, it sends a json request to a jqeury/ajax listener to reload page    

	def get_last_two
		
		if (Post.where('updated_at > ?', Time.now - 30.seconds).length > 0)
			
			@lasttwo = Post.limit(2).order('updated_at desc')
			render :json => { :data => @lasttwo }
		else
			
			render :json => { :data => {} }
		end
	end
	
	def display
		@posts = Post.all
		
		@lasttwo = Post.limit(2).order('updated_at desc')
		
		@newposts = Post.where('updated_at > ?', Time.now - 2.hours)
	end


end
