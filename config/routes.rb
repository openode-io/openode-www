# frozen_string_literal: true

Rails.application.routes.draw do

  get '/', to: 'home#index'
  get '/pricing', to: 'home#pricing'
  get '/pricing-private-cloud', to: 'home#private_cloud_pricing'
  get '/about', to: 'home#about'
  get '/news', to: 'home#news'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
