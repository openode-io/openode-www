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
  get '/open-source', to: 'home#opensource'

  get '/open-source/:slug', constraints: { slug: %r{[^/]+} }, to: 'home#opensource_item'

  resources :sessions, only: [:new, :create, :destroy]

  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get 'users/register'
  post '/users', to: 'users#create'
  get '/users/forgot_password', to: 'users#forgot_password'
  post '/users/forgot_password', to: 'users#process_forgot_password'
  # post 'users/process_forgot_password'
  get 'users/activate'

  get '/reset/:reset_token', to: 'users#verify_reset_token'

  get 'docs/:section/', to: 'docs#view'
  get 'docs/:section/:document', to: 'docs#view'
  
  get 'admin', to: 'admin#index'
  get 'admin/billing', to: 'admin#billing'
  get 'admin/billing/orders', to: 'admin#orders'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
