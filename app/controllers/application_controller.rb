# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '4b70c8f6aef22461743ee1c2c3a6d8d7'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  include AuthenticatedSystem
  
  helper_method :is_user_admin, :getCurrentTopic, :getNextTopic, :getCurrentUser, :getCurrentSessionUser
  
  protected
  
    def getRandomString
    
      chars = ("a"..."z").to_a + ("0".."9").to_a
      
      ret_val = "red_"
      
      1.upto(8) { |i| ret_val << chars[rand(chars.size - 1)] }
      
      return ret_val
    
    end
    
    def getCurrentTopic
    
      if @current_topic then @current_topic end
      
      @current_topic = Topic.find(:all, :order => "time_to_show DESC", :limit => 1, :conditions => ["time_to_show < ?", Time.now.utc])[0]
      
      getNextTopic
      
      @current_topic
    
    end
    
    def getNextTopic
    
      if @next_topic then @next_topic end
      
      @next_topic = Topic.find(:all, :order => "time_to_show ASC", :limit => 1, :conditions => ["time_to_show > ?", Time.now.utc])[0]
      
      @next_topic
    
    end
    
    #def getCurrentUser
    
      #return current_user
    
    #end
    
    def getCurrentSessionUser
    
      if @current_session_user
        return @current_session_user
      elsif session[:current_session_user_id]
        @current_session_user = SessionUser.find(session[:current_session_user_id])
        if @current_session_user[:topic_id] == getCurrentTopic()[:id]
          return @current_session_user
        end
      end
      
      return @current_session_user = setCurrentSessionUser
      
    end
    
    def setCurrentSessionUser
      # create new user and return it
      if current_user
        #user is logged in create session user for him/her
        current_user_session_user = SessionUser.find(:first, :conditions => ["topic_id = ? and user_id = ?", getCurrentTopic.id, current_user.id ])
        
        if current_user_session_user
          # there is already a session user for current user
          # use that
          # ignore existing session_user
          session[:current_session_user_id] = current_user_session_user.id
          
          return current_user_session_user
        else
          need_to_create_new_session_user = false
          # user existing session_user if any
          if !session[:current_session_user_id]
            need_to_create_new_session_user = true
          elsif SessionUser.find(session[:current_session_user_id], :include => :user).user != nil
            need_to_create_new_session_user = true
          end
          
          if need_to_create_new_session_user
            @current_session_user = SessionUser.get_new_with_random_username(getCurrentTopic, current_user)
            
            return @current_session_user
          else
            existing_session_user = SessionUser.find(session[:current_session_user_id])
            
            existing_session_user.user = current_user
            
            existing_session_user.save
            
            return existing_session_user
          end
        end
        
        return nil
      else
        @current_session_user = SessionUser.get_new_with_random_username(getCurrentTopic)

        session[:current_session_user_id] = @current_session_user.id
        
        return @current_session_user
      end
    end
    
    # following methods are used for authentication
    def is_user_admin
      @user_ip_addr = request.env['REMOTE_ADDR']
      
      if @user_ip_addr == "127.0.0.1" || @user_ip_addr == "116.75.148.146"
        return true
      end
      
      redirect_to root_path
      return false

    end
  
end
