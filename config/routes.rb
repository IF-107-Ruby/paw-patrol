require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :admin do
    get '/', to: 'dashboards#index', as: :dashboard
    resources :feedbacks, only: %i[index show destroy]
    resources :users, only: %i[index show edit update destroy] do
      post :impersonate, on: :member
      post :stop_impersonating, on: :collection
    end
  end

  namespace :company do
    get '/', to: 'companies#show'
    get 'edit', to: 'companies#edit'
    patch 'edit', to: 'companies#update'
    get 'dashboard', to: 'dashboards#show'
    get '/satisfaction', to: 'dashboards#satisfaction'
    get 'settings', to: 'settings#show'

    resource :access_token, only: %i[create update destroy]
    resources :users
    resources :units do
      resource :room_employees, only: %i[show edit update]
      resources :children, controller: :units_children, only: :index
      resources :events, except: %i[new edit] do
        get 'avaible_tickets', on: :collection
      end
    end
    resources :tickets, only: %i[show new create edit update] do
      post '/resolution', to: 'tickets#resolution', as: :resolution
      get  '/follow_up', to: 'tickets#followed_up', as: :followed
      resources :comments
      resource :watchers, only: %i[update]
      resource :review, except: %i[index destroy]
      get :resolved, on: :collection
    end
    resources :user_units, only: %i[index show]
  end

  devise_for :users, path: '', only: %i[sessions confirmations], controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :tickets, only: %i[index]
    end
  end

  root 'home#index'
  get  '/contact', to: 'feedbacks#new'

  unauthenticated do
    get  '/sign_up', to: 'companies#new'
    post '/sign_up', to: 'companies#create'
  end

  resources :feedbacks, only: :create

  # Using :match so that error pages work for all types of requests, not just GET.
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#server_errors', via: :all
end
