class UsersController < ApplicationController
  
   before_filter :login_required, only: [:show, :new, :edit, :update, :destroy , :home ]
  
  def dashboard
    @folders = Folder.all
    @phase = Phase.all
    @stories = Story.all
    @story = Story.new
    @users = User.all
    @user = User.new
    @userss = @users.count
    @vote = Story.order("created_at desc").limit(4)
  end
  
  def home
    
      @stories = Story.search(params[:search])

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
            unless u.folder.present?
                Appmailer.invite(u).deliver
            else  
                
                    if u.folder.phases.empty?
                        Appmailer.invitep(u).deliver
                    end
              
                u.folder.phases.each do |s|
                      if s.stories.empty?
                        Appmailer.invites(u).deliver
                      end
                 
                end
          end
        end
  end  
  def all
      @user = User.all
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
   
      flash[:success] = 'User was successfully destroyed.'
      redirect_to (:back)
      
  end
  def show
    @user = User.find(params[:id])
  end
  private
    def login_required
    unless current_user
      flash[:error] = 'You must be logged in to view this page.'
      redirect_to new_user_session_path
    end
  end
end
