Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      get '/', to: 'dashboards#index', as: :dashboard
    end
  end

  authenticate :user, ->(user) { user.company.present? } do
    namespace :company do
      get '/', to: 'companies#show'
      get 'edit', to: 'companies#edit'
      patch 'edit', to: 'companies#update'
      get 'dashboard', to: 'dashboards#show'
      resources :users
      resources :units do
        get :children, on: :member
      end
    end
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
  resources :units do
    resources :room_employees, only: :index
  end
  resources :feedbacks, only: %i[index show create destroy]
  resources :users
  resources :tickets, only: %i[show new create] do
    resources :comments
  end

  # Using :match so that error pages work for all types of requests, not just GET.
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#server_errors', via: :all
end
