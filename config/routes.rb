Rails.application.routes.draw do

  root 'delivery/main#index'

  namespace :delivery do
    root 'main#index'
    resources :items,         only: [:index, :show]
    resources :compositions,  only: [:index, :show]
    resources :tags,          only: [:index]
    resources :carts
    resources :orders
    resources :positions
    resources :users
    resources :sessions
    resources :subpositions, only: [:edit, :update]
    post '/add_to_cart',        to: 'carts#add_to_cart',            as: :add_to_cart
    post '/remove_from_cart',   to: 'carts#remove_from_cart',       as: :remove_from_cart
    post '/add_quantity',       to: 'subpositions#up_quantity',     as: :add_quantity
    post '/down_quantity',      to: 'subpositions#down_quantity',   as: :down_quantity
    post '/add_subposition',    to: 'subpositions#add_subposition', as: :add_subposition
    get 'login',                to: 'sessions#new',                 as: :login
    post 'logout' ,             to:  'sessions#destroy',            as: :logout
    get 'signin',               to: 'users#new',                    as: :signin
    get '/search',              to: 'main#index_with_tags',         as: :search
  end

  namespace :shop do
    root 'main#index'
    resources :users
    resources :items
    resources :carts
    resources :orders
    resources :positions
    resources :compositions
  end

  namespace :admin do
    root 'main#index'
    resources :items
    resources :compositions
    resources :tags
    resources :user
    resources :orders
    post 'admin/compositions/:id', to: 'compositions#add_item', as: :add_item
    put 'admin/compositions/:id/remove_tag', to: 'compositions#remove_tag', as: :remove_tag
  end

end
