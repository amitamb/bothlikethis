class SessionUserMessage < ActiveRecord::Base

  belongs_to :sender, :class_name => "SessionUser"
  belongs_to :receiver, :class_name => "SessionUser"

end
