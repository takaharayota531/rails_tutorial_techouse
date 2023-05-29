# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home'
  # get 'static_pages/home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # get 'static_pages/contact'

  get '/help', to: 'static_pages#help'
  get '/home', to: 'static_pages#home'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'users#new'

  resources :users
end
