Rails.application.routes.draw do

  resources :seasons, :only => [:index, :show]
  resources :categories, :only => [:index, :show]

  resources :outfits do
  	resources :items, only: [:show]
  end

  resources :items do
    resources :outfits, only: [:show, :index, :new, :create, :edit]
  end

  resources :item_outfits, only: [:create, :destroy]

  root 'static#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
