Rails.application.routes.draw do
  root 'home#index'

  resources :companies
  resources :units
  resources :feedbacks, only: %i[index show new create destroy]
end
