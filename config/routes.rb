Rails.application.routes.draw do

  resources :sections, only: [:show] do
    resources :section_user_invitations, path: 'user_invitations', only: [:new, :show, :create, :index]
    resources :trainings do
      member do
        post 'invitations'
      end
    end
    resources :users, path: 'members'
    resources :groups do
      post 'users' => 'groups#add_users', as: 'add_users'
      resources :users, only: [:destroy]
    end
  end

  resources :club_admin_roles, only: [:index, :show]

  resources :teams, only: [:index, :show]

  resources :ping, only: :index, :constraints => {:format => :json }

  resources :clubs, only: [:index, :show] do 
    resources :sections, only: [:index, :new, :create]
  end

  devise_for :users

  resources :users, only: [:show, :edit, :update] do
    member do
      match 'training_presences', via: [:get, :post]
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'visitors#index'
end
