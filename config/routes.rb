Rails.application.routes.draw do

  resources :seasons, :only => [:index, :show]
  resources :categories, :only => [:index, :show]
  
  resources :items
  resources :outfits
  
  root 'static#index', as: 'index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
