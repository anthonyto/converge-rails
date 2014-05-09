class Api::PicturesController < ApplicationController
  before_filter :get_event
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.where(event_id: params[:event_id])
  end

  # GET /pictures/1
  # GET /pictures/1.json
  api :GET, "/users/:user_uid/events/:event_id/picture/:id", "Show a single picture."
  param :user_uid, String, :desc => "User Facebook uid", :required => true
  param :id, String, :desc => "Event id", :required => true
  def show
  end

  # GET /pictures/new
  def new
    @event = Event.find(params[:event_id])
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  api :POST, "/users/:user_uid/event/:event_id/pictures", "Create a picture that belongs to an event."
  param :user_uid, String, :desc => "User that the event belongs to", :required => true
  param :event_id, String, :desc => "Event id", :required => true
  def create
    @picture = Picture.new(picture_params)
    @picture.event_id = params[:event_id]

    respond_to do |format|
      if @picture.save
        format.json { render :text => "That picture worked, yo." }
      else
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url }
      format.json { head :no_content }
    end
  end

  private
    def get_event
      @event = Event.find(params[:event_id])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:file_name, :time_taken, :event_id, :user_id, :image)
    end
end
