Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: "sessions" }

  resources :users, only: [] do
    collection do
      get 'update_avatar'
      post 'update_avatar'
    end
  end

  resources :moods, only: [:create]
end
