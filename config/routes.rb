require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  
  # sidekiq
  mount Sidekiq::Web => '/sidekiq'

  resources :categories, only: %i[index show new create]
  resources :companies, only: %i[new create]
  resources :events, only: %i[index show new create] do
    collection {get :search}

    member do
      post :invite
      post :event_request
    end
  end

  resources :event_requests, only: [] do
    member do
      put :accept
      put :decline
    end
  end

  resources :games, only: %i[new create show] do
    collection {get :search}
    member {patch :add}
  end

  resources :platforms, only: %i[index show new create]
  resources :states, only: [:show] do
    resources :cities, only: [:index]
  end

  resources :users, only: %i[edit update show] do
    collection {get :search}
    
    member do
      get :received_invites
      post :accept_invite
      post :decline_invite
      post :invite
    end
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :events, only: %i[index show]
      resources :games, only: %i[index destroy]
    end
  end
end
