class Opinion < ActiveRecord::Base

  belongs_to :session_user
  belongs_to :topic_attribute
 
  """
    Following attribute is used as alias for like_int
    it is boolean while like_int is int
  """
  def like=(val)
    if (val == true || val == "true")
      self.like_int = 1
    else
      self.like_int = -1
    end
  end
  
  def like
    if (self.like_int == 1)
      true
    else
      false
    end
  end

  """
    Gives list of opinions for current topic
      like_count - number of people that liked the attribute
      unlike_count - number of people that hate the attribute
    Includes information about provided session_user
      current_session_user_like_int - specifies whether user liked or hated the opinion
      '1' if he liked it OR '-1' if he hated it
  """
  def self.find_by_topic(topic, session_user, current_user = false)

    @opinions = Opinion.find_by_sql(" select *, SUM(case when like_int = 1 then 1 else 0 end) as like_count,
                                      SUM(case when like_int = -1 then 1 else 0 end) as unlike_count, 
                                      SUM(case when opinions.session_user_id = "+session_user.id.to_s() +" then opinions.like_int else 0 end) 
                                      as current_session_user_like_int  from opinions
                                      inner join session_users on session_users.id = opinions.session_user_id 
                                      inner join topic_attributes on topic_attributes.id = opinions.topic_attribute_id
                                      where session_users.topic_id = "+topic.id.to_s()+"
                                      group by opinions.topic_attribute_id
                                      order by (like_count + unlike_count) asc")
      
  end

end

#@opinions = Opinion.find(:all, :include => [:session_user, :topic_attribute, :similar], :conditions => ["session_users.topic_id=?", topic.id])

#@opinions = Opinion.find(:all, :select => "*", :include => [:session_user, :topic_attribute], :joins => "LEFT OUTER JOIN (select * from opinions where opinions.session_user_id = "+ session_user.id.to_s() +") as o2 ON opinions.topic_attribute_id = o2.topic_attribute_id",:conditions => ["session_users.topic_id=?", topic.id])

#@opinions = Opinion.find(:all, :select => "*", :include => [:session_user, :topic_attribute], :joins => "LEFT OUTER JOIN opinions as o2 ON opinions.topic_attribute_id = o2.topic_attribute_id",:conditions => ["session_users.topic_id=?", topic.id])

#opinionS.*, session_users.*, table_Attributes.*, o2.like_int as po

#@opinions = Opinion.find_by_sql("select * from (select * from opinions, session_users, topic_attributes where session_users.topic_id = "+ topic.id.to_s() +") as current_topic_o LEFT OUTER JOIN (select * from opinions where opinions.session_user_id = "+ session_user.id.to_s() +") as current_session_user_o ON current_topic_o.topic_attribute_id = current_session_user_o.topic_attribute_id ")

#@opinions = Opinion.find_by_sql("select current_topic_o.*, current_session_user_o.like_int as c_s_u_like_int from (select * from opinions INNER JOIN session_users on opinions.session_user_id = session_users.id INNER JOIN topic_attributes on opinions.topic_attribute_id = topic_attributes.id where session_users.topic_id = "+ topic.id.to_s() +") as current_topic_o LEFT OUTER JOIN (select * from opinions where opinions.session_user_id = "+ session_user.id.to_s() +") as current_session_user_o ON current_topic_o.topic_attribute_id = current_session_user_o.topic_attribute_id")

#@opinions = Opinion.find_by_sql('SELECT opinions.*, session_users.*, topic_attributes.*, o2.like_int as po FROM "opinions" LEFT OUTER JOIN "session_users" ON "session_users".id = "opinions".session_user_id LEFT OUTER JOIN "topic_attributes" ON "topic_attributes".id = "opinions".topic_attribute_id LEFT OUTER JOIN (select * from opinions where opinions.session_user_id = 11) as o2 ON opinions.topic_attribute_id = o2.topic_attribute_id WHERE (session_users.topic_id=1) ')

#@opinions = Opinion.find(:all, :include => [:session_user, :topic_attribute], :group => "topic_attribute_id, like_int", :conditions => ["session_users.topic_id=?", topic.id])

#@opinions_current_session_user = Opinion.find_by_sql("select * from (select opinions.* from opinions, session_users where session_users.topic_id = "+ topic.id.to_s() +") as current_topic_o LEFT OUTER JOIN (select * from opinions where opinions.session_user_id = "+ session_user.id.to_s() +") as current_session_user_o ON current_topic_o.topic_attribute_id = current_session_user_o.topic_attribute_id ")

#@opinions = Opinion.count(:session_user_id, :include => [:session_user, :topic_attribute], :group => "topic_attribute_id, like_int", :conditions => ["session_users.topic_id=?", topic.id])

#@opinions = Opinion.find_by_sql("select * from (select * from opinions INNER JOIN session_users ON opinions.session_user_id = session_users.id INNER JOIN topic_attributes ON opinions.topic_attribute_id = topic_attributes.id where session_users.topic_id = "+ topic.id.to_s() +") as current_topic_o LEFT OUTER JOIN (select * from opinions where opinions.session_user_id = "+ session_user.id.to_s() +") as current_session_user_o ON current_topic_o.topic_attribute_id = current_session_user_o.topic_attribute_id")

#@opinions = Opinion.find_by_sql("select opinions.*, session_users.given_username, topic_attributes.text, count(opinions.id) from opinions INNER JOIN session_users ON opinions.session_user_id = session_users.id INNER JOIN topic_attributes ON opinions.topic_attribute_id = topic_attributes.id where session_users.topic_id = "+ topic.id.to_s() + " and opinions.session_user_id != "+ session_user.id.to_s() +" group by opinions.topic_attribute_id, opinions.like_int")

#@opinions = Opinion.find(:all, :include => [:session_user, :topic_attribute], :conditions => ["session_users.id != "+session_user.id.to_s() +" and session_users.topic_id=?", topic.id])

#if current_user == false
  ##@opinions = Opinion.find_by_sql("select * from (select *, count(*) as like_unlike_count from (select * from opinions inner join session_users on session_users.id = opinions.session_user_id where opinions.session_user_id != "+ session_user.id.to_s() +" and session_users.topic_id = "+topic.id.to_s()+") group by topic_attribute_id, like_int) as opinions inner join topic_attributes on topic_attributes.id = opinions.topic_attribute_id")

  #@opinions = Opinion.find_by_sql("select * from (select *, count(*) as like_unlike_count from (select * from opinions inner join session_users on session_users.id = opinions.session_user_id where session_users.topic_id = "+topic.id.to_s()+" and topic_attribute_id not in (select topic_attributes.id from topic_attributes inner join opinions on opinions.topic_attribute_id = topic_attributes.id inner join session_users on session_users.id = opinions.session_user_id where session_users.id = "+ session_user.id.to_s() +")) group by topic_attribute_id, like_int ) as opinions inner join topic_attributes on topic_attributes.id = opinions.topic_attribute_id")
#else
  ##@opinions = Opinion.find_by_sql("select * from opinions inner join session_users on session_users.id = opinions.session_user_id inner join topic_attributes on topic_attributes.id = opinions.topic_attribute_id where opinions.session_user_id = "+ session_user.id.to_s() +" and session_users.topic_id = "+topic.id.to_s()+"")

  #@opinions = Opinion.find_by_sql("select * from (select *, count(*) as like_unlike_count from (select * from opinions inner join session_users on session_users.id = opinions.session_user_id where session_users.topic_id = "+topic.id.to_s()+" and topic_attribute_id in (select topic_attributes.id from topic_attributes inner join opinions on opinions.topic_attribute_id = topic_attributes.id inner join session_users on session_users.id = opinions.session_user_id where session_users.id = "+ session_user.id.to_s() +")) group by topic_attribute_id, like_int ) as opinions inner join topic_attributes on topic_attributes.id = opinions.topic_attribute_id")
#end

