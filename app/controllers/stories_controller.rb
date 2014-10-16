class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]
 before_filter :login_required, only: [:show, :new, :edit, :update, :destroy]
  # GET /stories
  # GET /stories.json
  def index
     @folders =  Folder.where(user_id: "#{current_user.id}")
    @stories = Story.all
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
     @folders =  Folder.where(user_id: "#{current_user.id}")
end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)

    respond_to do |format|
      if @story.save
        flash[:success] = 'Story was successfully created.'
        format.html { redirect_to folders_path }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
         flash[:success] = 'Story was successfully updated.'
        format.html { redirect_to folders_path  }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end
   
  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      flash[:error] = 'Story was successfully destroyed.'
      format.html { redirect_to stories_url }
      format.json { head :no_content }
    end
  end
  def vote
    value = params[:type] == "up" ? 1 : -1
    @story = Story.find(params[:id])
    @story.add_or_update_evaluation(:votes, value, current_user)
   end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:describtion , :phase_id , :heading )
    end
  def login_required
    unless current_user
      flash[:error] = 'You must be logged in to view this page.'
      redirect_to new_user_session_path
    end
  end
    

end
