class OpinionsController < ApplicationController
  # GET /opinions
  # GET /opinions.xml
  def index
    #  => :suburbs
    #@opinions = Opinion.find(:all, :include => [:session_user], :conditions => ["session_users.topic_id=?", getCurrentTopic.id]) #getCurrentSessionUser.o
    @opinions = Opinion.find_by_topic(getCurrentTopic)
    #@opinions = getCurrentSessionUser.opinions.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @opinions }
    end
  end

  # GET /opinions/1
  # GET /opinions/1.xml
  def show
    @opinion = Opinion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @opinion }
    end
  end

  # GET /opinions/new
  # GET /opinions/new.xml
  def new
    @opinion = getCurrentSessionUser.opinions.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @opinion }
    end
  end

  # GET /opinions/1/edit
  def edit
    @opinion = getCurrentSessionUser.opinions.find(params[:id])
  end

  # POST /opinions
  # POST /opinions.xml
  def create
    @opinion = getCurrentSessionUser.opinions.new(params[:opinion])
    
    @opinion_text = params[:opinion_text].strip
    
    if !(@topic_attribute = TopicAttribute.find(:first, :include => :opinions, :conditions => [ "lower(text) = ?", @opinion_text.downcase]))
      @topic_attribute = TopicAttribute.new
      
      @topic_attribute.text = @opinion_text
      
      @new_topic_attribute = true
    
    else
    
      @new_topic_attribute = false
      
    end
    
    @attrib_opinions_count = @topic_attribute.opinions.count + 1 # since new one is getting added
    
    if @attrib_opinions_count == 0
      @attrib_opinions_count = 1
    end
    
    @topic_attribute.weight = 1.0 / @attrib_opinions_count
    
    # See if at end
    #@topic_attribute.save
    
    #@opinion.session_user = getCurrentSessionUser
    @opinion.topic_attribute = @topic_attribute
    
    current_session_user = SessionUser.find(getCurrentSessionUser.id)
    
    @session_user_opinions_count = current_session_user.opinions.count + 1 # since new one is getting added
    
    if @session_user_opinions_count == 0
      @session_user_opinions_count = 1
    end
    
    current_session_user.weight = 1.0 / @session_user_opinions_count
    
    current_session_user.save
    
    # update it in rjs template
    # required for helper get_topic_attribute_cell_info in application_helper
    
    @opinion[:text] = @topic_attribute.text
    
    # a string
    # in ubuntu
    @opinion[:current_session_user_like_int] = @opinion.like_int.to_s()
    
    like_count = 0
    unlike_count = 0
    
    for opinion in @topic_attribute.opinions
    
      if opinion.like
        like_count += 1
      else
        unlike_count += 1
      end
    
    end
    
    @opinion[:like_count] = like_count
    @opinion[:unlike_count] = unlike_count

    respond_to do |format|
      if @topic_attribute.save && @opinion.save
        format.html { flash[:notice] = 'Opinion was successfully created.'
                      redirect_to root_path }
        format.xml  { render :xml => @opinion, :status => :created, :location => @opinion }
        
        format.js
      else
        format.html { redirect_to root_path }
        format.xml  { render :xml => @opinion.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /opinions/1
  # PUT /opinions/1.xml
  def update
    @opinion = getCurrentSessionUser.opinions.find(params[:id])

    respond_to do |format|
      if @opinion.update_attributes(params[:opinion])
        flash[:notice] = 'Opinion was successfully updated.'
        format.html { redirect_to(@opinion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @opinion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /opinions/1
  # DELETE /opinions/1.xml
  def destroy
    @opinion = getCurrentSessionUser.opinions.find(params[:id], :conditions => ["session_user_id=?", getCurrentSessionUser.id])
    @opinion.destroy

    respond_to do |format|
      format.html { redirect_to(opinions_url) }
      format.xml  { head :ok }
    end
  end
end
