Homophones::Application.routes.draw do
  
  devise_for :users

  root :to => "home#home"
  namespace :admin do
    match 'index'
    match 'login'
    match 'logout'
    resources :homophone_sets
  end

  match '/about_homophones' => "home#about"
  resources :homophone_sets
  match '/quiz' => 'questions#random'
  resources :questions
end
