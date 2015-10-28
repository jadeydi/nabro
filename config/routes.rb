Rails.application.routes.draw do

  scope module: :api do
#    constraints subdomain: 'api' do
      resources :base, only: [:index]
      scope :v1 do
        resource :users, only: [] do
          collection do
            post :sign_up
            post :sign_in
          end
        end
      end
#    end
  end

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
