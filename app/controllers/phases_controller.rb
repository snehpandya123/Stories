class PhasesController < ApplicationController
  before_action :set_phase, only: [:show, :edit, :update, :destroy]
before_filter :login_required, only: [:show, :new, :edit, :update, :destroy]
  # GET /phases
  # GET /phases.json
  def index
    @folders =  Folder.where(user_id: "#{current_user.id}")
    @phases = Phase.all
  end

  # GET /phases/1
  # GET /phases/1.json
  def show
    @story  = Story.new
     @phase = Phase.find(params[:id])
    @pha = @phase.stories
    @count = @pha.count
       @folders =  Folder.where(user_id: "#{current_user.id}")
     @stories =  Story.where(phase_id: @phase)
    
  end

  # GET /phases/new
  def new
    @phase = Phase.new
  end

  # GET /phases/1/edit
  def edit
     @folders =  Folder.where(user_id: "#{current_user.id}")
  end

  # POST /phases
  # POST /phases.json
  def create
    @phase = Phase.new(phase_params)

    respond_to do |format|
      if @phase.save
        flash[:success] = 'Phase was successfully created.'
        format.html { redirect_to folders_path }
        format.json { render :index, status: :created, location: @phase }
      else
        format.html { render :new }
        format.json { render json: @phase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phases/1
  # PATCH/PUT /phases/1.json
  def update
    respond_to do |format|
      if @phase.update(phase_params)
       flash[:error] ='Phase was successfully updated.'
        format.html { redirect_to folders_path }
        format.json { render :show, status: :ok, location: @phase }
      else
        format.html { render :edit }
        format.json { render json: @phase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phases/1
  # DELETE /phases/1.json
  def destroy
    @phase.destroy
    respond_to do |format|
       flash[:success] = 'Phase was successfully destroyed.'
      format.html { redirect_to folders_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phase
      @phase = Phase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phase_params
      params.require(:phase).permit(:name ,:folder_id)
    end
    def login_required
    unless current_user
      flash[:error] = 'You must be logged in to view this page.'
      redirect_to new_user_session_path
    end
  end
end
