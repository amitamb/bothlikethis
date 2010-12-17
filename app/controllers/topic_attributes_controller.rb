class TopicAttributesController < ApplicationController

  before_filter :is_user_admin

  # GET /topic_attributes
  # GET /topic_attributes.xml
  def index
    @topic_attributes = TopicAttribute.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topic_attributes }
    end
  end

  # GET /topic_attributes/1
  # GET /topic_attributes/1.xml
  def show
    @topic_attribute = TopicAttribute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic_attribute }
    end
  end

  # GET /topic_attributes/new
  # GET /topic_attributes/new.xml
  def new
    @topic_attribute = TopicAttribute.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic_attribute }
    end
  end

  # GET /topic_attributes/1/edit
  def edit
    @topic_attribute = TopicAttribute.find(params[:id])
  end

  # POST /topic_attributes
  # POST /topic_attributes.xml
  def create
    @topic_attribute = TopicAttribute.new(params[:topic_attribute])

    respond_to do |format|
      if @topic_attribute.save
        flash[:notice] = 'TopicAttribute was successfully created.'
        format.html { redirect_to(@topic_attribute) }
        format.xml  { render :xml => @topic_attribute, :status => :created, :location => @topic_attribute }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic_attribute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topic_attributes/1
  # PUT /topic_attributes/1.xml
  def update
    @topic_attribute = TopicAttribute.find(params[:id])

    respond_to do |format|
      if @topic_attribute.update_attributes(params[:topic_attribute])
        flash[:notice] = 'TopicAttribute was successfully updated.'
        format.html { redirect_to(@topic_attribute) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic_attribute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topic_attributes/1
  # DELETE /topic_attributes/1.xml
  def destroy
    @topic_attribute = TopicAttribute.find(params[:id])
    
    @topic_attribute.opinions.each do |opinion|
      opinion.destroy
    end
  
    @topic_attribute.destroy

    respond_to do |format|
      format.html { 
                    redirect_to(root_path)
                    #topic_attributes_url
                  }
      format.xml  { head :ok }
    end
  end
end
