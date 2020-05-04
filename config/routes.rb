Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get  '/about', to: 'static_pages#about'
  get  '/services', to: 'static_pages#services'
  get  '/contact', to: 'feedbacks#new'

  resources :companies
  resources :units
  resources :feedbacks, only: %i[index show create destroy]
  resources :users
  resources :tickets

  # Using :match so that error pages work for all types of requests, not just GET.
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#server_errors', via: :all
end
