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
  post '/support', to: 'home#send_support'
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
  get 'users/activate'

  get '/reset/:reset_token', to: 'users#verify_reset_token'

  get 'docs/:section/', to: 'docs#view'
  get 'docs/:section/:document', to: 'docs#view'
  
  namespace :admin do
    get '/', to: 'instances#index' 
    get 'account', to: 'account#index'
    get 'billing', to: 'billing#index'
    get 'billing/orders', to: 'billing#orders'
    get 'instances', to: 'instances#index'
    get 'instances/plans', to: 'instances#plans' 
    get 'instances/available-locations', to: 'instances#available_locations' 
    get 'api', to: 'api#index'
    get 'support', to: 'support#index'
    get 'account/notifications', to: 'account#notifications'
    get 'account/newsletter', to: 'account#newsletter'

    # Instance Actions
    post 'instances/create', to: 'instances#create'
    post 'instances/:id/deploy', to: 'instances#deploy'
    post 'instances/:id/stop', to: 'instances#stop'
    post 'instances/:id/delete', to: 'instances#delete'

    get 'instances/:id/edit', to: 'instances#edit'
    get 'instances/:id/stats', to: 'instances#stats'

    # Collaborators
    get 'instances/:id/collaborators', to: 'collaborators#index'

    get 'instances/:id/logs', to: 'instances#logs'
    get 'instances/:id/deployments', to: 'instances#deployments'

    get 'instances/:id/access', to: 'instances#access'

    get 'notifications', to: 'notifications#index'
    get 'notifications/latest', to: 'notifications#latest'
    post 'notifications/:id/mark_read', to: 'notifications#mark_read'
    post 'notifications/mark_viewed', to: 'notifications#mark_viewed'

    get 'account/api', to: 'account#account_api'
  end

  namespace :super_admin do
    get '/', to: 'home#index' 

    get '/websites', to: 'websites#index' 

    get '/users', to: 'users#index'
    get '/users/:id/custom_order', to: 'users#custom_order'
    post '/users/:id/custom_order', to: 'users#make_order'

    get '/notifications', to: 'notifications#index'
    get '/notifications/new', to: 'notifications#new'
    post '/notifications', to: 'notifications#create'
    delete '/notifications/:id', to: 'notifications#destroy'

    get '/newsletters', to: 'newsletters#index'
    get '/newsletters/new', to: 'newsletters#new'
    post '/newsletters', to: 'newsletters#create'
    post '/newsletters/:id/deliver', to: 'newsletters#deliver'
  end
end
