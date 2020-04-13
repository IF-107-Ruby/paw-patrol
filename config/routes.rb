Rails.application.routes.draw do
  root 'home#index'
  resources :feedbacks, only: %i[index show create destroy]
end
