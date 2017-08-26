Rails.application.routes.draw do

  resources :items
  resources :outfits
  resources :categories, :only => [:show]
  
  root 'static#index', as: 'index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
