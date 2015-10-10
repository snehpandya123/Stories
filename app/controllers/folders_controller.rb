class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]
   before_filter :login_required, only: [:show, :new, :edit, :update, :destroy , :index]
  # GET /folders
  # GET /folders.json
  def index
     
   @folders =  Folder.where(user_id: "#{current_user.id}")
    @fol = @folders.count
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
     @folders =  Folder.where(user_id: "#{current_user.id}")
    @folder = Folder.find(params[:id])
    @fol = @folder.phases
    @count = @fol.count
    @phase = Phase.new
     @phases =  Phase.where(folder_id: @folder)
  end

  # GET /folders/new
  def new
    @folder = Folder.new
  end

  # GET /folders/1/edit
  def edit
     @folders =  Folder.where(user_id: "#{current_user.id}")
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new(folder_params)

    respond_to do |format|
      if current_user.folder.present?
        flash[:danger] = 'You have already created your life'
      else
      if @folder.save
        flash[:success] = 'Life was successfully created.'
        format.html { redirect_to folders_path }
        format.json { render :index, status: :created, location: @folder }
      else
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        flash[:success] = 'Life was successfully updated.'
        format.html { redirect_to @folder }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to folders_url, notice: 'Folder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name , :user_id)
    end
    private
    def login_required
    unless current_user
      flash[:error] = 'You must be logged in to view this page.'
      redirect_to new_user_session_path
    end
  end

end
