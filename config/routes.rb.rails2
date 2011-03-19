ActionController::Routing::Routes.draw do |map|
  map.resources :session_user_messages


  map.resources :opinions

  map.resources :topic_attributes


  map.resources :topics

  map.resources :users

  map.resources :session_users
  
  map.root :controller=>"home", :action => "index"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
