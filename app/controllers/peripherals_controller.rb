class PeripheralsController < ApplicationController
  	
	
	def index
		@posts = Post.all
		
		@lasttwo = Post.limit(2).order('updated_at desc')
		
		@newposts = Post.where('updated_at > ?', Time.now - 2.hours)
	end

# Checks database for updated entries. if there are some, it sends a json request to a jqeury/ajax listener to reload page    
	def chech_db
		@newposts = Post.where('updated_at > ?', Time.now - 2.hours)
	end

end
