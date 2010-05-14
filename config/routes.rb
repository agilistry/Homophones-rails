ActionController::Routing::Routes.draw do |map|
  map.home '/', :controller => 'homophone_sets', :action => 'index'
  map.admin '/admin', :controller => 'admin', :action => 'home'
  map.login '/admin/login', :controller => 'admin', :action => 'login'
  map.about '/about_homophones', :controller => 'home', :action => 'about'
  map.namespace :admin do |admin|
    admin.resources :homophone_sets
  end
  map.resources :homophone_sets, :collection => {:search => :get}
  map.quiz '/quiz', :controller => 'questions', :action => 'random'
  map.resources :questions
end
