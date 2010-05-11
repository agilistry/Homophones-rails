ActionController::Routing::Routes.draw do |map|
  map.home '/', :controller => 'home', :action => 'home'
  map.admin '/admin', :controller => 'admin', :action => 'home'
  map.login '/admin/login', :controller => 'admin', :action => 'login'
end
