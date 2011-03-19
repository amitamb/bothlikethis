# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def get_topic_attribute_cell_info(opinion)

    like_text = ""
              
    if opinion[:current_session_user_like_int] == "1"
      like_text += "You "
        if opinion[:like_count] > 0
          like_text += "and "
        end
    end
    
    if opinion[:like_count] == 0
      if opinion[:current_session_user_like_int] != "1"
        like_text += "No one"
      end
    else
      like_text += " " + pluralize(opinion[:like_count],"person")
    end
    
    #######################################
    
    unlike_text = ""
              
    if opinion[:current_session_user_like_int] == "-1"
      unlike_text += "You "
        if opinion[:unlike_count] > 0
          unlike_text += "and "
        end
    end
    
    if opinion[:unlike_count] == 0
      if opinion[:current_session_user_like_int] != "-1"
        unlike_text += "No one"
      end
    else
      unlike_text += " " + pluralize(opinion[:unlike_count],"person")
    end

    #######################################
    
    text = opinion[:text]
    
    #######################################
    
    if opinion[:current_session_user_like_int] == "0"
    
      show_like_button = true
      show_unlike_button = true
    
    else
    
      show_like_button = false
      show_unlike_button = false
    
    end
    
    #######################################
    
    #######################################
    
    retVal = {:like_text => like_text,
              :text => text,
              :unlike_text => unlike_text,
              :show_like_button => show_like_button,
              :show_unlike_button => show_unlike_button}
              
    return retVal;
  
  end

end
