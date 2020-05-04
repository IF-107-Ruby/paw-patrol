Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      get '/', to: 'dashboards#index', as: :dashboard
    end
  end

  devise_for :users, path: '', only: :sessions, controllers: {
    sessions: 'users/sessions'
  }

  root 'home#index'
  get  '/about', to: 'static_pages#about'
  get  '/services', to: 'static_pages#services'
  get  '/contact', to: 'feedbacks#new'
  get  '/sign_up', to: 'companies#new'
  post '/sign_up', to: 'companies#create'

  resources :companies
  resources :units
  resources :feedbacks, only: %i[index show create destroy]
  resources :users
  resources :tickets,   only: %i[show new create]

  # Using :match so that error pages work for all types of requests, not just GET.
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#server_errors', via: :all
end
