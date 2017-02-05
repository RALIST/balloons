Rails.application.routes.draw do
  mount LetsencryptPlugin::Engine, at: '/'
  match "/404", to: "errors#not_found", :via => :all
  match "/500", to: "errors#internal_server_error", :via => :all

  constraints subdomain: 'shop' do
    scope module: 'shop' do
      mount LetsencryptPlugin::Engine, at: '/'
      root 'main#index'
      resources :users
      resources :items
      resources :carts
      resources :orders
      resources :positions
      resources :compositions
    end
  end

  namespace :admin, module: 'admin' do
    root 'main#index'
    resources :items
    resources :compositions
    resources :tags
    resources :users
    resources :orders
    resources :sessions
    resources :prices, only: [:new, :create]
    put '/delete/:id',                        to: 'compositions#delete',        as: :delete_composition
    post '/admin/compositions/:id',            to: 'compositions#add_item',      as: :add_item
    put '/admin/compositions/:id/remove_tag',  to: 'compositions#remove_tag',    as: :remove_tag
    put '/admin/compositions/:id/remove_receiver',  to: 'compositions#remove_receiver',    as: :remove_receiver
    get '/update_price/:id',                  to: 'compositions#update_price',  as: :update_price
    get '/login', to: 'sessions#new', as: :login
    get '/compositions/:id/remove_item', to: 'compositions#remove_item', as: :remove_item
  end

  scope module: 'delivery' do
    root 'main#index'
    resources :items,         only: [:index, :show]
    resources :compositions,  only: [:index, :show]
    resources :tags,          only: [:index]
    resources :carts
    resources :orders
    resources :positions
    resources :users
    resources :sessions
    resources :subpositions, only: [:edit, :update, :destroy]
    resources :calls, only: [:new, :create]
    post '/add_to_cart/:id',        to: 'carts#add_to_cart',            as: :add_to_cart
    post '/remove_from_cart/:id',   to: 'carts#remove_from_cart',       as: :remove_from_cart
    post '/add_quantity/:id',       to: 'subpositions#up_quantity',     as: :add_quantity
    post '/down_quantity/:id',      to: 'subpositions#down_quantity',   as: :down_quantity
    post '/add_subposition',        to: 'subpositions#add_subposition', as: :add_subposition
    get '/login',                    to: 'sessions#new',                 as: :login
    post '/logout' ,                 to:  'sessions#destroy',            as: :logout
    get '/signin',                   to: 'users#new',                    as: :signin
    get '/search',                  to: 'main#search',                  as: :search
    get '/cart',                 to: 'carts#show',                   as: :my_cart
    get '/price', to: 'main#price',  as: :price_range
    get '/account', to: 'users#show',  as: :account
    get '/for', to: 'main#for', as: :with_receivers
    get '/thank_you', to: 'main#thanks', as: :thanks
  end
end
