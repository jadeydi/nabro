Rails.application.routes.draw do

  scope module: :api do
#    constraints subdomain: 'api' do
      resources :base, only: [:index]
      resources :users, only: [:show] do
        collection do
          post :reset_password
          put  :update_avatar
          post :sign_up
          post :sign_in
        end
      end
      put :users, to: 'users#update'
      resources :attempts
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
  resources :attempts
  resources :comments
  resources :user_attempts, only: [:create, :index] do
    member do
      post :done
      post :discard
    end
  end

end
