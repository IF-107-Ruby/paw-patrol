Rails.application.routes.draw do
  root 'home#index'

  resources :companies do
    resources :units
  end
end
