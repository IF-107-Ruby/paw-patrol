Rails.application.routes.draw do
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
    resources :users
    resources :units do
      resources :room_employees, only: :index
      resources :children, controller: :units_children, only: :index
    end
    resources :tickets, only: %i[show new create] do
      resources :comments
    end
    resources :user_units, only: %i[index show]
  end

  devise_for :users, path: '', only: :sessions, controllers: {
    sessions: 'users/sessions'
  }

  root 'home#index'
  get  '/about', to: 'static_pages#about'
  get  '/services', to: 'static_pages#services'
  get  '/contact', to: 'feedbacks#new'

  unauthenticated do
    get  '/sign_up', to: 'companies#new'
    post '/sign_up', to: 'companies#create'
  end

  resources :companies
  resources :units
  resources :feedbacks, only: :create
  resources :users

  # Using :match so that error pages work for all types of requests, not just GET.
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#server_errors', via: :all
end
