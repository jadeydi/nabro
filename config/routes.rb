Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: "sessions" }

  resources :moods, only: [:create]
end
