Rails.application.routes.draw do

  root 'static#index', as: 'index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
