Rails.application.routes.draw do
  root 'static_pages#home'
  # get 'static_pages/home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # get 'static_pages/contact'

  get '/help', to:'static_pages#help'
  get '/home', to:'static_pages#home'
  get '/contact', to:  'static_pages#contact'
  get '/about',to: 'static_pages#about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
