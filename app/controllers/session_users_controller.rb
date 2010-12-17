class SessionUsersController < ApplicationController

  before_filter :is_user_admin

  # GET /session_users
  # GET /session_users.xml
  def index
    @session_users = SessionUser.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @session_users }
    end
  end

  # GET /session_users/1
  # GET /session_users/1.xml
  def show
    @session_user = SessionUser.find(params[:id])
    
    # since view needs variables initialized by
    # following function
    current_session_user = getCurrentSessionUser
    
    @session_user_message = @session_user.received_messages.new
    
    

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @session_user }
    end
  end

  # GET /session_users/new
  # GET /session_users/new.xml
  def new
    @session_user = SessionUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @session_user }
    end
  end

  # GET /session_users/1/edit
  def edit
    @session_user = SessionUser.find(params[:id])
  end

  # POST /session_users
  # POST /session_users.xml
  def create
    @session_user = SessionUser.new(params[:session_user])

    respond_to do |format|
      if @session_user.save
        flash[:notice] = 'SessionUser was successfully created.'
        format.html { redirect_to(@session_user) }
        format.xml  { render :xml => @session_user, :status => :created, :location => @session_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @session_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /session_users/1
  # PUT /session_users/1.xml
  def update
    @session_user = SessionUser.find(params[:id])

    respond_to do |format|
      if @session_user.update_attributes(params[:session_user])
        flash[:notice] = 'SessionUser was successfully updated.'
        format.html { redirect_to(@session_user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @session_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /session_users/1
  # DELETE /session_users/1.xml
  def destroy
    @session_user = SessionUser.find(params[:id])
    @session_user.destroy

    respond_to do |format|
      format.html { redirect_to(session_users_url) }
      format.xml  { head :ok }
    end
  end
end
