class Api::EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  api :GET, "/users/:user_uid/events", "Show all events that belong to a user."
  param :user_uid, String, :desc => "User Facebook uid", :required => true
  def index
    @events = Event.where(uid: params[:user_uid])
  end

  # GET /events/1
  # GET /events/1.json
  api :GET, "/users/:user_uid/events/:id", "Show details and all image urls for a single event."
  param :user_uid, String, :desc => "User Facebook uid", :required => true
  param :id, String, :desc => "Event id", :required => true
  def show
  end
  
  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  api :GET, "/users/:user_uid/events/:id/edit", "Edit an event."
  param :user_uid, String, :desc => "User Facebook uid", :required => true
  param :id, String, :desc => "Event id", :required => true
  def edit
  end

  # POST /events
  # POST /events.json
  api :POST, "/users/:user_uid/events/", "Create an event underneath a user."
  param :user_uid, String, :desc => "User that the event belongs to", :required => true
  param :name, String, :desc => "Event name", :required => true
  param :uid, String, :desc => "This belongs in the body, same as url parameter user_uid", :required => true
  param :location, String, :desc => "Event location", :required => true
  param :start_time, DateTime, :desc => "Start time", :required => true
  param :end_time, DateTime, :desc => "End time", :required => true
  def create
    @event = Event.new(event_params)    

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
