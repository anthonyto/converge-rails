class Api::EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  api :GET, "/users/:user_uid/events", "Show all events that user belongs to."
  param :user_uid, String, :desc => "User Facebook uid", :required => true
  def index
    if(!User.exists?(uid: params[:user_uid]))
      user = User.create({uid: params[:user_uid]})
    else
      user = User.find(params[:user_uid])
    end
    @events = user.events.order(start_time: :desc)
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
  
  # GET /events/1/invite
  api :POST, "/users/:user_uid/events/:id/invite", "Invite friends to an event."
  param :user_uid, String, :desc => "User Facebook uid", :required => true
  param :event_id, String, :desc => "Event id", :required => true
  # param :_json, String, :desc => "JSON object of friends to invite", :required => true
  def invite
    event = Event.find(params[:event_id])
    friends = params[:_json]
    friends.each do |friend|
      if(!User.exists?(uid: friend[:friend][:uid]))
        user = User.create({name: friend[:friend][:name], uid: friend[:friend][:uid]})
      else
        user = User.find(friend[:friend][:uid])
      end
      event.users << user if !event.users.exists?(user)
    end
    
    render :nothing => true
    # render plain: "Friends were successfully invited."
  end
  

  # POST /events
  # POST /events.json
  api :POST, "/users/:user_uid/events/", "Create an event underneath a user."
  param :user_uid, String, :desc => "Users Facebook Uid", :required => false
  param :name, String, :desc => "Event name", :required => false
  param :uid, String, :desc => "This belongs in the body, same as url parameter user_uid", :required => false
  param :location, String, :desc => "Event location", :required => false
  param :start_time, DateTime, :desc => "Start time", :required => false
  param :end_time, DateTime, :desc => "End time", :required => false
  def create
    user = User.where(uid: params[:user_uid])
    @event = Event.new(event_params)    
    @event.users << user

    respond_to do |format|
      if @event.save
        format.json { render :text => "That event worked, yo." }
      else
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
