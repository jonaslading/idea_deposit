require 'dropbox_sdk'
require 'base64'

# This is an example of a Rails 3 controller that authorizes an application
# and then uploads a file to the user's Dropbox.

# You must set these
ROOT_FOLDER = "/IdeBanken/" # Name of the shared dropbox folder
APP_KEY = "1znic8owutrq2r6"
APP_SECRET = "iwbpegroh2dilfn"
ACCESS_TYPE = :dropbox #The two valid values here are :app_folder and :dropbox
                          #The default is :app_folder, but your application might be
                          #set to have full :dropbox access.  Check your app at
                          #https://www.dropbox.com/developers/apps

class PostsController < ApplicationController
 	

	
	def index
		if  not session[:dropbox_session] then
			redirect_to :action => 'authorize', :notice => "you need to be logged in"
		else
			dbsession = DropboxSession.deserialize(session[:dropbox_session])
			if !dbsession.authorized? then
				redirect_to :action => 'authorize', :notice => "session not authorized"
			else
				session[:dropbox_session] = dbsession.serialize
				
				@posts = Post.order('title Asc')
				@post = Post.new
				@latest = Post.limit(3).order('updated_at desc')


			end
		end
	end
	
	def show
		
		@post = Post.find(params[:id])
		
		@dbdata = OpenStruct.new
		@dbdata.filenames=[]
#		@dbdata.thumbs=[]
			
		dbsession = DropboxSession.deserialize(session[:dropbox_session])
		client = DropboxClient.new(dbsession, ACCESS_TYPE) #raise an exception if session not authorized
		info = client.account_info
		dbcontentdata = client.metadata(ROOT_FOLDER+@post.title)
		link = client.shares(ROOT_FOLDER+@post.title)
		@folderlink = link['url']
		
		dbcontentdata['contents'].each do |i|
	#code for generating thumbnail pictures for dropbox content - but it's buggy at the moment		
# 			if i['thumb_exists'] #should check if there is a thumbnail, but doesn't work
# 				@dbdata.thumbs.push(Base64.strict_encode64(client.thumbnail(i['path'].delete(' '),'xs'))) #throws error "thre is no thumbnail..."
# 			else	
# 				@dbdata.thumbs.push('iVBORw0KGgoAAAANSUhEUgAAAAUA
# AAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO
# 9TXL0Y4OHwAAAABJRU5ErkJggg==')
# 
# 			end	
			@dbdata.filenames.push(i['path'].split('/').last)
		end
		
		#log activity
		record_activity("looked at idea: "+@post.title, "#{info['display_name']}")
		
	end
	
	
	def create
		@post = Post.new(params[:post])
		dbsession = DropboxSession.deserialize(session[:dropbox_session])
		client = DropboxClient.new(dbsession, ACCESS_TYPE) #raise an exception if session not 
		info = client.account_info
		@post.modified_by = "#{info['display_name']}" 
		
		#adds user to color table if he's not there already
		color = Color.find_or_create_by_user(:user => "#{info['display_name']}")
		@post.color_id = color.id
		
		if @post.save
		
			#log activity
			record_activity("created idea: "+@post.title, @post.modified_by)
			
			#creates a idea-folder in the shared dropbox directory
			client.file_create_folder(ROOT_FOLDER+params[:post][:title])
			redirect_to posts_path, :notice => "Your idea was saved"
		else
			
			redirect_to posts_path, :notice => "Your idea was NOT saved. Ideas must both a have unique title and content."
		end
	end
	
	
	def update
		@post = Post.find(params[:id])
		dbsession = DropboxSession.deserialize(session[:dropbox_session])
		client = DropboxClient.new(dbsession, ACCESS_TYPE) #raise an exception if session not authorized
		info = client.account_info
		@post.modified_by = "#{info['display_name']}" 
		
		color = Color.find_or_create_by_user(:user => "#{info['display_name']}")
		@post.color_id = color.id

		if @post.update_attributes(params[:post])
			
			#log activity			
			record_activity("updated idea: "+@post.title, @post.modified_by)
			
			redirect_to posts_path, :notice => "Your idea has been updated"
		else
			redirect_to post_path(params[:id]), :notice => "Your idea was Not updated. All idea must have content."

		end
	end
	
	def destroy
		@post = Post.find(params[:id])
		dbsession = DropboxSession.deserialize(session[:dropbox_session])
		client = DropboxClient.new(dbsession, ACCESS_TYPE) #raise an exception if session not authorized
		info = client.account_info

			#creates a idea-folder in the shared dropbox directory
		client.file_delete(ROOT_FOLDER+@post.title)
		
			#log activity
		record_activity("deleted at idea: "+@post.title, "#{info['display_name']}")
		
		@post.destroy
		redirect_to posts_path, :notice => "Post has been deleted"
	end
	
	def authorize
        if not params[:oauth_token] then
            dbsession = DropboxSession.new(APP_KEY, APP_SECRET)

            session[:dropbox_session] = dbsession.serialize #serialize and save this DropboxSession

            #pass to get_authorize_url a callback url that will return the user here
            redirect_to dbsession.get_authorize_url url_for(:action => 'authorize')
        else
            # the user has returned from Dropbox
            dbsession = DropboxSession.deserialize(session[:dropbox_session])
            dbsession.get_access_token  #we've been authorized, so now request an access_token
            session[:dropbox_session] = dbsession.serialize

            redirect_to :controller => 'posts' 
        end
    end
    
    def record_activity(activity, name)
	    @log = ActivityLog.new
	    @log.user = name
	    @log.activity = activity
	    @log.ip_address = request.env['REMOTE_ADDR']
	    @log.save
    end
end
