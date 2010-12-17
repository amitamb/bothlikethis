class HomeController < ApplicationController

  def index
    
    @like_opinion = Opinion.new
    @like_opinion.like = true
    @like_opinion.action_type = 1
    
    @dislike_opinion = Opinion.new
    @dislike_opinion.like = false
    @dislike_opinion.action_type = 1
    
    @opinion_form = Opinion.new
    @opinion_form.like = true
    @opinion_form.action_type = 2
    
    @other_opinions = []
    @my_opinions = []
    
    @opinions = Opinion.find_by_topic(getCurrentTopic, getCurrentSessionUser, true)
    
    @similar_session_users = getCurrentSessionUser.similar_session_users
    
  end

end
