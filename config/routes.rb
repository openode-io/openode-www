# frozen_string_literal: true

Rails.application.routes.draw do

  root :to => 'home#index'

  get '/', to: 'home#index'
  get '/pricing', to: 'home#pricing'
  get '/pricing-private-cloud', to: 'home#private_cloud_pricing'
  get '/about', to: 'home#about'
  get '/news', to: 'home#news'
  get '/locations', to: 'home#locations'
  get '/openode-cli', to: 'home#openode_cli'
  get '/faq', to: 'home#faq'
  get '/support', to: 'home#support'
  get '/terms', to: 'home#terms'
  get '/privacy', to: 'home#privacy'

  resources :sessions, only: [:new, :create, :destroy]

  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get 'users/register'
  post '/users', to: 'users#create'
  get 'users/forgot_password'
  post 'users/process_forgot_password'
  get 'users/activate'

  get 'blog', to: 'blog#index'
  get 'blog/post/:id', to: 'blog#post'

  get 'docs', to: 'docs#index'
  get 'doc/:id', to: 'docs#view'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
