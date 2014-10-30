class UsersController < ApplicationController
  def dashboard
    @folders = Folder.all
    @phase = Phase.all
    @stories = Story.all
    @user = User.all
    @users = @user.count
    @vote = Story.order("created_at desc").limit(4)
  	
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
  def invite
     @user = User.all
        @user.each do |u|
            if u.folders.empty?
                Appmailer.invite(u).deliver
            end  
                u.folders.each do |p|
                    if p.phases.empty?
                        Appmailer.invitep(u).deliver
                    end
                p.phases.each do |s|
                      if s.stories.empty?
                        Appmailer.invites(u).deliver
                      end
                  end 
                end
          end
  end  
end
