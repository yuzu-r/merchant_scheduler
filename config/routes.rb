Rails.application.routes.draw do
  
  #get 'users/new'

  resources :merchants
  resources :users
  get 'help' => 'static_pages#help'
  root 'static_pages#home'


end
