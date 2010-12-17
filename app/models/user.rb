class User < ActiveRecord::Base

  has_many :session_users

end
