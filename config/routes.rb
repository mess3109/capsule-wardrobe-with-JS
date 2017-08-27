Rails.application.routes.draw do

  resources :seasons, :only => [:index, :show]
  resources :categories, :only => [:index, :show]

  resources :outfits

  resources :items do
    resources :outfits, only: [:show, :index, :new, :create, :edit]
  end

  resources :line_items, only: [:create]

  root 'static#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
