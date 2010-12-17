class SessionUser < ActiveRecord::Base

  belongs_to :topic
  
  belongs_to :user
  
  has_many :opinions
  has_many :topic_attributes, :through => :opinions
  
  has_many :sent_messages, :class_name => "SessionUserMessage", :foreign_key => "sender_id"
	has_many :receivers, :through => :sent_messages
	has_many :received_messages, :class_name => "SessionUserMessage", :foreign_key => "receiver_id"
	has_many :senders, :through => :received_messages, :source => :session_user
  
  #validation
  validates_presence_of :topic_id
  
  def similar_session_users   
    #V1
    #@similar_session_users = SessionUser.find_by_sql("select session_users.*, sum(attrib.weight * o1.like_int * o2.like_int) as match_score from opinions as o1, opinions as o2, topic_attributes as attrib, session_users where o1.topic_attribute_id = o2.topic_attribute_id and o1.session_user_id != o2.session_user_id and o1.topic_attribute_id = attrib.id and o2.session_user_id = session_users.id  and o1.session_user_id = " + id.to_s() +" group by o2.session_user_id order by match_score desc")
   
    #V2	added macth_score > 0
    @similar_session_users = SessionUser.find_by_sql("select * from (select session_users.*, sum(attrib.weight * o1.like_int * o2.like_int) as match_score from opinions as o1, opinions as o2, topic_attributes as attrib, session_users where o1.topic_attribute_id = o2.topic_attribute_id and o1.session_user_id != o2.session_user_id and o1.topic_attribute_id = attrib.id and o2.session_user_id = session_users.id  and o1.session_user_id = " + id.to_s() +" group by o2.session_user_id order by match_score desc) where match_score > 0 ")
    
    return @similar_session_users
  
  end
  
  def self.get_new_for_topic(topic)

    session_user = SessionUser.new
    
    new_given_name = PossibleName.find_by_sql("select * from possible_names where name not in (select given_username from session_users where session_users.topic_id = " + topic.id.to_s() + ") order by RANDOM() LIMIT 1")[0]

    session_user.given_username = new_given_name.name

    session_user.topic = topic

    session_user.save
    
    return session_user

  end

end
