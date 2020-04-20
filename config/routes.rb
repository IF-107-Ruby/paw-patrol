Rails.application.routes.draw do
  root 'home#index'

  resources :companies do
    resources :units
    resources :members, only: :index
  end

  resources :feedbacks, only: %i[index show create destroy]
  resources :users

  # Using :match so that error pages work for all types of requests, not just GET.
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#server_errors', via: :all
end
