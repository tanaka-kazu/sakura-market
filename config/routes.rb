Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'items#index'
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :users
  resources :shopping_carts, only:[:index]
  resources :items, only:[:index, :show]
  resource :shopping_cart, only: [:show, :update, :create, :destroy] do
    get 'order'
    resources :items, only: [:add, :remove], controller: 'shopping_carts' do
      get 'add'
      get 'remove'
    end
  end
  resource :user, only: [:show, :update] do
    resource :delivery_info, only:[:new, :edit, :create, :update] do
      resource :order, only:[:create]
    end
    resources :orders, only:[:index, :show, :create]
  end
end
