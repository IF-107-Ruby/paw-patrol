Rails.application.routes.draw do
  root 'home#index'

  resources :companies
  resources :units
end
