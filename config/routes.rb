ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users
  
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'

  map.resource :session

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
