# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'

  get '/help', to: 'static_pages#help'
  get '/home', to: 'static_pages#home'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/microposts', to: 'static_pages#home'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: %i[new create edit update]
  resources :microposts, only: %i[create destroy]
end
