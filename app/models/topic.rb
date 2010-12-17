class Topic < ActiveRecord::Base

  has_many :session_users
  
  #validation
  validates_presence_of :name
  validates_presence_of :image_url
  validates_presence_of :time_to_show

end
