Rails.application.routes.draw do

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
