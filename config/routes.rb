Rails.application.routes.draw do

  root 'delivery/main#index'

  namespace :delivery do
    root 'main#index'
    resources :items,         only: [:index, :show]
    resources :compositions,  only: [:index, :show]
    resources :carts
    resources :orders,        only: [:new, :create]
    resources :positions,     only: [:new, :create]
    resources :users
    post '/add_to_cart', to: 'carts#add_to_cart', as: :add_to_cart
  end

  namespace :shop do
    root 'main#index'
    resources :users
    resources :items,         only: [:index, :show]
    resources :carts,         only: [:new, :create]
    resources :orders,        only: [:new, :create]
    resources :positions,     only: [:new, :create]
  end

  namespace :admin do
    root 'main#index'
    resources :items
    resources :compositions
    resources :tags
    resources :user
    post 'admin/compositions/:id', to: 'compositions#add_item', as: :add_item
  end
 
end