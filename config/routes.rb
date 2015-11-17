Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: "sessions" }

  resources :users, only: [] do
    collection do
      get 'update_avatar'
      post 'update_avatar'
    end
  end

  resources :states, only: [:create]

  scope module: :api do
    constraints subdomain: 'api' do
    resources :base, only: [:index]
    resource :users, only: [] do
      collection do
        post :sign_up
        post :sign_in
      end
    end

    resource :states, only: [:create]
    end
  end

end
