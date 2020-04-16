Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :companies do
    resources :members, only: :index
  end

  resources :units
  resources :feedbacks, only: %i[index show create destroy]
  resources :users
  resources :companies

  # Using :match so that error pages work for all types of requests, not just GET.
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#server_errors', via: :all
end
