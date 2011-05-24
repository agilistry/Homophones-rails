Homophones::Application.routes.draw do
  
  devise_for :users

  root :to => "home#home"
  #match "/admin", :controller => 'Admin::HomophoneSets', :action => 'index'
  namespace :admin do
    match 'index'
    match 'login'
    match 'logout'
    match 'homophones' => 'Admin::HomophoneSets', :action => 'index'
    resources :homophone_sets
  end

  #match '/admin/homophones' => 'Admin::HomophoneSets', :action => 'index'

  match '/about_homophones' => "home#about"
  resources :homophone_sets do
    collection do
      get 'search'
    end
  end
  match '/quiz' => 'questions#random'
  resources :questions
end
