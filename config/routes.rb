Rails.application.routes.draw do
  
  resources :merchants
  #get 'static_pages/help'
  get 'help' => 'static_pages#help'
  root 'static_pages#home'


end
