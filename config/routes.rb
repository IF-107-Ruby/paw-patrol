Rails.application.routes.draw do
  resources :feedbacks, only: %i[index show new create destroy]
end
