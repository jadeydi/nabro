Rails.application.routes.draw do

  scope module: :api do
#    constraints subdomain: 'api' do
      resources :base, only: [:index]
      resources :users, only: [:show] do
        collection do
          post :reset_password
          put  :update_avatar
          post :signup
          post :login
        end
      end
      put :users, to: 'users#update'

      resource :states, only: [:create]
#    end
  end

  root 'home#index'

  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/sign_up' => 'devise/registrations#new', :as => 'new_user_registration'
    post 'users' => 'devise/registrations#create', :as => 'user_registration'
  end

  resource :users, only: [:edit, :update] do
    collection do
      get :update_avatar
      post :update_avatar
    end
  end

  resources :states, only: [:create]


end
