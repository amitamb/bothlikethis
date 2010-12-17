ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address        => 'mumsmtp.hathway.com',
  :port           =>  25,
  :domain         => 'hathway.com',
  :authentication => :login,
  :user_name      => 'amitambardekar',
  :password       => '100$112#108@'
}
