Rails.application.routes.draw do

  constraints subdomain: '' do
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
    resources :tasks do
      member do
        patch :archive
      end
    end
    resources :comments
    resources :attempts, only: [:create] do
      member do
        post :done
        post :discard
      end
    end

    resources :activities, only: [:index]

    resources :pages, only: [:show]
  end

  scope module: :api do
    constraints subdomain: 'api' do
      resources :base, only: [:index]
      resources :users, only: [:show] do
        collection do
          post :reset_password
          put  :update_avatar
          post :sign_up
          post :sign_in
          get :me
        end
      end
      put :users, to: 'users#update'
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
      resources :comments
      get 'activities', to: 'activities#index'
      resources :attempts, only: [:create] do
        member do
          put :done
          put :discard
        end
      end
    end
  end

end
