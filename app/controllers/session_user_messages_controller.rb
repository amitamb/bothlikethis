class SessionUserMessagesController < ApplicationController

  before_filter :is_user_admin, :except => [:create, :destroy]

  # POST /session_user_messages
  # POST /session_user_messages.xml
  def create
    @session_user_message = SessionUserMessage.new(params[:session_user_message])
    
    @session_user_message.sender = getCurrentSessionUser

    respond_to do |format|
      if @session_user_message.save
        format.html { redirect_to(@session_user_message.receiver, :notice => 'Message was successfully created.')
											#redirect_to(@session_user_message, :notice => 'SessionUserMessage was successfully created.') 
										}
        format.xml  { render :xml => @session_user_message, :status => :created, :location => @session_user_message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @session_user_message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /session_user_messages/1
  # DELETE /session_user_messages/1.xml
  def destroy
    @session_user_message = SessionUserMessage.find(params[:id])
    @session_user_message.destroy

    respond_to do |format|
      format.html { redirect_to(@session_user_message.receiver, :notice => 'Message was successfully deleted.')
										#redirect_to(session_user_messages_url) 
									}
      format.xml  { head :ok }
    end
  end
  
  # Following actions will not be accessible to user except admin
  
  # PUT /session_user_messages/1
  # PUT /session_user_messages/1.xml
  def update
    @session_user_message = SessionUserMessage.find(params[:id])

    respond_to do |format|
      if @session_user_message.update_attributes(params[:session_user_message])
        format.html { redirect_to(@session_user_message, :notice => 'SessionUserMessage was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @session_user_message.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /session_user_messages/1/edit
  def edit
    @session_user_message = SessionUserMessage.find(params[:id])
  end
  
  # GET /session_user_messages/new
  # GET /session_user_messages/new.xml
  def new
    @session_user_message = SessionUserMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @session_user_message }
    end
  end
  
  # GET /session_user_messages
  # GET /session_user_messages.xml
  def index
    @session_user_messages = SessionUserMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @session_user_messages }
    end
  end

  # GET /session_user_messages/1
  # GET /session_user_messages/1.xml
  def show
    @session_user_message = SessionUserMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @session_user_message }
    end
  end

end
