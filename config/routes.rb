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
    get 'account/notifications_and_newsletter', to: 'account#notifications_and_newsletter'
    patch 'account/notifications_and_newsletter', to: 'account#update_notifications_and_newsletter'
    get 'account/api_access', to: 'account#api_access'
    post 'account/regenerate_token', to: 'account#regenerate_token'
    get 'account/profile', to: 'account#profile'

    get 'billing', to: 'billing#index'
    get 'billing/orders', to: 'billing#orders'
    get 'billing/spending', to: 'billing#spending'
    get 'billing/pay', to: 'billing#pay'

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

    get 'instances/:id/settings', to: 'instance_settings#index', as: :instance_settings
    get 'instances/:id/settings/plan', to: 'instance_settings#plan', as: :instance_settings_plan
    patch 'instances/:id/settings/plan', to: 'instance_settings#change_plan'
    get 'instances/:id/settings/dns_and_aliases', to: 'instance_settings#dns_and_aliases', as: :instance_settings_dns_and_aliases
    post 'instances/:id/settings/aliases', to: 'instance_settings#add_alias'
    delete 'instances/:id/settings/aliases/:domain', to: 'instance_settings#remove_alias'
    get 'instances/:id/settings/ssl', to: 'instance_settings#ssl', as: :instance_settings_ssl
    get 'instances/:id/settings/scheduler',
      to: 'instance_settings#scheduler',
      as: :instance_settings_scheduler
    patch 'instances/:id/settings/scheduler',
      to: 'instance_settings#update_scheduler'

    # persistence
    get 'instances/:id/settings/persistence',
      to: 'instance_settings#persistence',
      as: :instance_settings_persistence
    delete 'instances/:id/settings/persistence', to: 'instance_settings#destroy_persistence'
    patch 'instances/:id/settings/change_size',
      to: 'instance_settings#change_size'

    get 'instances/:id/settings/misc', to: 'instance_settings#misc', as: :instance_settings_misc
    patch 'instances/:id/settings/misc',
      to: 'instance_settings#update_misc',
      as: :instance_settings_patch_misc

    get 'instances/:id/stats', to: 'instances#stats'

    # Collaborators
    get 'instances/:id/collaborators', to: 'collaborators#index', as: :instance_collaborators
    get 'instances/:id/collaborators/new', to: 'collaborators#new', as: :instance_collaborators_new
    get 'instances/:id/collaborators/:collaborator_id', to: 'collaborators#edit', as: :instance_collaborator_edit
    post 'instances/:id/collaborators', to: 'collaborators#create'
    delete 'instances/:id/collaborators/:collaborator_id', to: 'collaborators#delete', as: :instance_collaborator_delete


    get 'instances/:id/logs', to: 'instances#logs'
    
    get 'instances/:id/access/',
      to: 'instance_access#index',
      as: :instance_access_index
    get 'instances/:id/access/deployments',
      to: 'instance_access#deployments',
      as: :instance_access_deployments
    get 'instances/:id/access/console',
      to: 'instance_access#console',
      as: :instance_access_console
    get 'instances/:id/access/activity_stream',
      to: 'instance_access#activity_stream',
      as: :instance_access_activity_stream
    get 'instances/:id/access/event/:event_id',
      to: 'instance_access#event'
    get 'instances/:id/access/cmd',
      to: 'instance_access#cmd',
      as: :instance_access_cmd      

    get 'instances/:id/credits', to: 'instances#credits', as: :instance_credits

    get 'notifications', to: 'notifications#index'
    get 'notifications/latest', to: 'notifications#latest'
    post 'notifications/:id/mark_read', to: 'notifications#mark_read'

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
