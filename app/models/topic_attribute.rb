class TopicAttribute < ActiveRecord::Base

  has_many :opinions
  has_many :session_users, :through => :opinions
  
  validates_presence_of :text
  
  #after_destroy :destroy_orphaned_opinions

  private

  def destroy_orphaned_opinions
    opinions.each do |opinion|
      opinion.destroy if opinion.topic_attribute.empty?
    end
  end

end
