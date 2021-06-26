# frozen_string_literal: true

Rails.application.routes.draw do

  root :to => 'home#index'

  get '/', to: 'home#index'
  get '/on-demand-pricing', to: 'home#on_demand_pricing'
  get '/pricing', to: 'home#pricing'
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
  get '/kb', to: 'home#kb'
  get '/templates', to: 'home#templates'

  get '/open-source/:slug', constraints: { slug: %r{[^/]+} }, to: 'home#opensource_item'
  get '/blog/:name', to: 'blog#post'

  resources :sessions, only: [:new, :create, :destroy]

  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get 'users/register'
  post '/users', to: 'users#create'
  get '/users/forgot_password', to: 'users#forgot_password'
  post '/users/forgot_password', to: 'users#process_forgot_password'
  get '/activate/:user_id/:activation_token', to: 'users#activate'

  get '/reset/:reset_token', to: 'users#verify_reset_token'

  get 'docs/:section/', to: 'docs#view'
  get 'docs/:section/:document', to: 'docs#view'

  get 'addons/:section/', to: 'docs#addons'
  get 'addons/:section/:document', to: 'docs#addons'
  
  namespace :admin do
    get '/', to: 'instances#index' 

    get 'account', to: 'account#index'
    patch 'account', to: 'account#update'
    patch 'account/password', to: 'account#change_password'
    delete 'account', to: 'account#destroy'

    get 'account/notifications',
      to: 'account#notifications'
    patch 'account/notifications_and_newsletter',
      to: 'account#update_notifications_and_newsletter'
    get 'account/api_access', to: 'account#api_access'
    post 'account/regenerate_token', to: 'account#regenerate_token'
    get 'account/profile', to: 'account#profile'

    get 'billing', to: 'billing#index'
    get 'billing/orders', to: 'billing#orders'
    get 'billing/spending', to: 'billing#spending'
    get 'billing/pay', to: 'billing#pay'
    get 'billing/subscription', to: 'billing#subscription'
    delete 'billing/subscriptions/:id/cancel', to: 'billing#cancel_subscription'

    get 'instances', to: 'instances#index'
    get 'instances/plans', to: 'instances#plans' 
    get 'instances/available-locations', to: 'instances#available_locations' 
    get 'api', to: 'api#index'
    get 'support', to: 'support#index'
    get 'invite', to: 'account#invite'
    post 'invite', to: 'account#send_invite'
    get 'account/notifications', to: 'account#notifications'
    get 'account/newsletter', to: 'account#newsletter'

    # Instance Actions
    post 'instances/create', to: 'instances#create'
    post 'instances/:id/deploy', to: 'instances#deploy'
    post 'instances/:id/stop', to: 'instances#stop'
    post 'instances/:id/delete', to: 'instances#delete'

    get 'instances/:id/settings', to: 'instance_settings#index', as: :instance_settings
    get 'instances/:id/settings/plan', to: 'instance_settings#plan', as: :instance_settings_plan
    get 'instances/:id/settings/address', to: 'instance_settings#address',
                                          as: :instance_settings_address
    patch 'instances/:id/settings/address', to: 'instance_settings#change_address'
    patch 'instances/:id/settings/plan', to: 'instance_settings#change_plan'
    get 'instances/:id/settings/location', to: 'instance_settings#location',
                                            as: :instance_settings_location
    patch 'instances/:id/settings/location', to: 'instance_settings#change_location'

    # dns and alias
    get 'instances/:id/settings/dns_and_aliases',
      to: 'instance_settings#dns_and_aliases',
      as: :instance_settings_dns_and_aliases
    post 'instances/:id/settings/aliases',
      to: 'instance_settings#add_alias'
    delete 'instances/:id/settings/aliases/:domain',
      to: 'instance_settings#remove_alias'

    get 'instances/:id/settings/ssl',
      to: 'instance_settings#ssl',
        as: :instance_settings_ssl
    patch 'instances/:id/settings/ssl',
      to: 'instance_settings#update_ssl'

    get 'instances/:id/settings/scheduler',
      to: 'instance_settings#scheduler',
      as: :instance_settings_scheduler
    patch 'instances/:id/settings/scheduler',
      to: 'instance_settings#update_scheduler'

    get 'instances/:id/settings/env',
      to: 'instance_settings#env',
      as: :instance_settings_env
    patch 'instances/:id/settings/env',
      to: 'instance_settings#update_env'
    delete 'instances/:id/settings/env/:variable_name',
      to: 'instance_settings#delete_env'

    # addons
    get 'instances/:id/settings/addons/new',
      to: 'instance_settings#new_addon'

    get 'instances/:id/settings/addons/:addon_id',
      to: 'instance_settings#edit_addon'

    post 'instances/:id/settings/addons/',
      to: 'instance_settings#create_addon'

    patch 'instances/:id/settings/addons/:addon_id',
      to: 'instance_settings#update_addon'

    delete 'instances/:id/settings/addons/:addon_id',
      to: 'instance_settings#destroy_addon'

    # persistence
    get 'instances/:id/settings/persistence',
      to: 'instance_settings#persistence',
      as: :instance_settings_persistence
    delete 'instances/:id/settings/persistence', to: 'instance_settings#destroy_persistence'
    patch 'instances/:id/settings/change_size',
      to: 'instance_settings#change_size'
    post 'instances/:id/settings/storage_areas',
      to: 'instance_settings#create_storage_area'
    delete 'instances/:id/settings/storage_areas/:b64volume',
      to: 'instance_settings#destroy_storage_area'

    get 'instances/:id/settings/misc', to: 'instance_settings#misc', as: :instance_settings_misc
    patch 'instances/:id/settings/misc',
      to: 'instance_settings#update_misc',
      as: :instance_settings_patch_misc

    get 'instances/:id/settings/alerts',
      to: 'instance_settings#alerts', as: :instance_settings_alerts
    patch 'instances/:id/settings/alerts',
      to: 'instance_settings#update_alerts',
      as: :instance_settings_patch_alerts

    get 'instances/:id/stats', to: 'instances#stats'

    # Collaborators
    get 'instances/:id/collaborators', to: 'collaborators#index', as: :instance_collaborators
    get 'instances/:id/collaborators/new', to: 'collaborators#new', as: :instance_collaborators_new
    get 'instances/:id/collaborators/:collaborator_id',
      to: 'collaborators#edit',
      as: :instance_collaborator_edit
    post 'instances/:id/collaborators/:collaborator_id',
      to: 'collaborators#update'
    post 'instances/:id/collaborators',
      to: 'collaborators#create'
    delete 'instances/:id/collaborators/:collaborator_id',
      to: 'collaborators#delete',
      as: :instance_collaborator_delete


    get 'instances/:id/logs', to: 'instances#logs'
    
    get 'instances/:id/access/',
      to: 'instance_access#index',
      as: :instance_access_index
    get 'instances/:id/access/deployments',
      to: 'instance_access#deployments',
      as: :instance_access_deployments
    get 'instances/:id/access/deployments/:deployment_id',
      to: 'instance_access#deployment',
      as: :instance_access_deployment
    post 'instances/:id/access/deployments/:deployment_id/rollback',
      to: 'instance_access#rollback',
      as: :instance_access_rollback_deployment
    get 'instances/:id/access/console',
      to: 'instance_access#console',
      as: :instance_access_console
    get 'instances/:id/access/activity_stream',
      to: 'instance_access#activity_stream',
      as: :instance_access_activity_stream
    get 'instances/:id/access/resources_usage',
      to: 'instance_access#resources_usage',
      as: :instance_access_resources_usage
    get 'instances/:id/access/status',
      to: 'instance_access#status',
      as: :instance_access_status
    get 'instances/:id/access/logs',
      to: 'instance_access#logs',
      as: :instance_access_logs
    post 'instances/:id/access/logs',
      to: 'instance_access#logs'
    get 'instances/:id/access/event/:event_id',
      to: 'instance_access#event'
    post 'instances/:id/access/cmd',
      to: 'instance_access#cmd',
      as: :instance_access_cmd   
    get 'instances/:id/access/snapshots',
      to: 'instance_access#snapshots',
      as: :instance_access_snapshots
    post 'instances/:id/access/snapshots',
      to: 'instance_access#create_snapshot'
    get 'instances/:id/access/list-snapshots',
      to: 'instance_access#list_snapshots'
    get 'instances/:id/access/snapshots/:snapshot_id',
      to: 'instance_access#get_snapshot'
    get 'instances/:id/access/one-click-app',
      to: 'instance_access#one_click_app',
      as: :instance_access_one_click_app
    post 'instances/:id/access/one-click-app',
      to: 'instance_access#create_one_click_app'
    get 'instances/:id/access/configure-one-click-app',
      to: 'instance_access#configure_one_click_app'
    patch 'instances/:id/access/update-one-click-app',
      to: 'instance_access#update_one_click_app'
    get 'instances/:id/access/deploy',
      to: 'instance_access#deploy',
      as: :instance_access_deploy
    post 'instances/:id/access/deploy',
      to: 'instance_access#do_deploy'

    get 'instances/:id/credits', to: 'instances#credits', as: :instance_credits

    get 'notifications', to: 'notifications#index'
    get 'notifications/latest', to: 'notifications#latest'
    post 'notifications/:id/mark_read', to: 'notifications#mark_read'

    get 'account/api', to: 'account#account_api'
  end

  namespace :super_admin do
    get '/', to: 'home#index' 
    get '/deployments', to: 'home#deployments' 

    get '/stats', to: 'stats#index' 

    get '/orders', to: 'orders#index'

    get '/websites', to: 'websites#index'
    get '/websites/:id', to: 'websites#view'
    get '/websites/:id/open_source', to: 'websites#open_source'
    post '/websites/:id/open_source', to: 'websites#update_open_source'

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
