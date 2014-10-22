class UsersController < ApplicationController
  def dashboard
    @folders = Folder.all
    @phase = Phase.all
    @stories = Story.all
    @user = User.all
    @users = @user.count
    @vote = Story.order(:created_at).limit(4)
  	
  end
  def home
  	 @stories = Story.order('created_at desc').page(params[:page])
 
 
  end
  def myphase
  	@folders =  Folder.where(user_id: "#{current_user.id}")
  	
  end
  def mystories
  	@folders =  Folder.where(user_id: "#{current_user.id}")
  end

end
