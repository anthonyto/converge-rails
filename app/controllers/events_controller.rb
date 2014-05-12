require 'rubygems'
require 'zip'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = current_user.events.order(start_time: :desc)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @picture = Picture.new
  end
  
  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end
  
  def download
    event = Event.find(params[:event_id])
    pictures = event.pictures
    t = Tempfile.new("awesome")
    
    Zip::OutputStream.open(t.path) do |z|
      pictures.each do |picture|
        # data = open(picture.image.url)
        z.put_next_entry(picture.image_file_name)
        z.print(URI.parse(picture.image.url).read)
        # z.put_next_entry(Paperclip.io_adapters.for(picture.image).read)
        # z.print IO.read(picture.image.url)
      end
    end
    
    send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => "Awesome.zip"

    t.close 
  end
  
  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)    
    @event.users << current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to user_events_path(current_user.uid), notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :location, :start_time, :end_time, :description, :uid)
    end
end
