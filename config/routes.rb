Rails.application.routes.draw do
  root 'home#index'

  resources :companies do
    resources :members, only: :index
  end

  resources :units
  resources :feedbacks, only: %i[index show create destroy]
  resources :users
end
