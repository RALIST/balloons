

Rails.application.routes.draw do


  namespace :admin, module: 'admin' do
    root 'main#index'
    resources :items
    resources :compositions
    resources :tags
    resources :users
    resources :orders
    resources :sessions
    resources :prices
    resources :types
    resources :colors
    resources :categories
    resources :tones
    resources :vendors
    resources :textures
    resources :sizes
    resources :products
    resources :foil_forms
    resources :subcategories
    resources :promotions
    resources :partners
    post '/parse_price', to: 'prices#parse_price', as: :parse_price
    post '/destroy_items', to: 'items#destroy_items', as: :destroy_items
    get '/get_images', to: 'items#get_images', as: :get_images
    put '/delete/:id', to: 'compositions#delete', as: :delete_composition
    post '/admin/compositions/:id',            to: 'compositions#add_item',      as: :add_item
    put '/admin/compositions/:id/remove_tag',  to: 'compositions#remove_tag',    as: :remove_tag
    put '/admin/compositions/:id/remove_receiver', to: 'compositions#remove_receiver', as: :remove_receiver
    get '/update_price/:id', to: 'compositions#update_price', as: :update_price
    get '/login', to: 'sessions#new', as: :login
    get '/compositions/:id/remove_item', to: 'compositions#remove_item', as: :remove_item
    get 'download_price', to: 'main#download_price', as: :download
  end

  scope module: 'delivery' do
    root 'main#index'
    get '/:city', to: 'main#index', constraints: {city: /#{User::CITIES.map{|c| "(#{c})"}.join('|')}/}
    scope '(:city)', city:  /#{User::CITIES.map{|c| "(#{c})"}.join('|')}/ do
      resources :compositions,  only: %i[index show]
      resources :tags, path: 'events' do
        resources :compositions, only: :show, path: ''
        collection do
          get 'vypusknoi-iz-sadika', to: 'graduations#kg', as: :kg
          get 'vypusknoi-iz-shkoly', to: 'graduations#school', as: :school
        end
      end
      scope'gelievie-shary' do
        resources :colors
        resources :categories
        resources :forms
        resources :products, path: ''

      end
      resources :carts
      resources :orders
      resources :positions
      resources :users
      resources :sessions
      resources :subpositions, only: %i[edit update destroy]
      resources :calls, only: %i[new create]
      resources :business, only: :index
      resources :graduations, only: :index
      resources :receivers, path: 'persons' do
        resources :compositions, only: :show, path: ''
      end
      resources :feedbacks, only: %i[index new create], path: 'otzivy'
      scope '/graduations' do
        get 'universitet', to: 'graduations#univ', as: :univ
      end
      post '/add_to_cart/:id',              to: 'carts#add_to_cart',        as: :add_to_cart
      post '/add_product_to_cart/:id',  to: 'carts#add_product_to_cart',    as: :add_product_to_cart
      post '/apply_code',               to: 'carts#apply_code',             as: :apply_code
      delete '/remove_from_cart/:id',     to: 'carts#remove_from_cart',       as: :remove_from_cart
      post '/add_quantity/:id',         to: 'subpositions#up_quantity',     as: :add_quantity
      post '/down_quantity/:id',        to: 'subpositions#down_quantity',   as: :down_quantity
      post '/add_subposition',          to: 'subpositions#add_subposition', as: :add_subposition
      get '/login',                     to: 'sessions#new',                 as: :login
      post '/logout', to: 'sessions#destroy', as: :logout
      get '/signin',                    to: 'users#new',                    as: :signin
      get '/search',                    to: 'main#search',                  as: :search
      get '/my_cart',                   to: 'carts#show',                   as: :my_cart
      get '/cp',                        to: 'users#show',                   as: :cp
      get '/cp/edit',                   to: 'users#edit',                   as: :edit_cp
      post '/by_price',                 to: 'main#by_price'
      get '/by_price',                  to: 'main#by_price',                as: :price_range
      get '/account',                   to: 'users#show',                   as: :account
      get '/thank_you',                 to: 'main#thanks',                  as: :thanks
      get '/contacts', to: 'main#contacts', as: :contacts
      post '/fogot_password', to: 'users#fogot_password', as: :fogot_password
      get '/lp', to: redirect('/', status: 301)
      get '/prices', to: 'main#prices', as: :prices
      get '/o-nas', to: 'main#about', as: :about
      get '/dostavka', to: 'main#info', as: :info
      get '/garantee', to: 'main#garant', as: :garant
      match '/404', to: 'errors#not_found', via: :all
      match '/500', to: 'errors#internal_server_error', via: :all
      get '/partners', to: 'partners#index', as: :partners
      get '/faq', to: 'main#faq', as: :faq
      constraints(format: /[a-z]+(\.[a-z]+)?/) do
        resources :sitemaps, only: :show
        get '/sitemap', to: 'sitemaps#show'
      end
      get '/wmail_8a207e840240fa656dd60c5e3d164964.html', to: redirect('/wmail_8a207e840240fa656dd60c5e3d164964.html')
      get '/yandex_889bff755caf54ec.html', to: redirect('/yandex_889bff755caf54ec.html')
      get '/google6c964074640a2edf.html', to: redirect('/google6c964074640a2edf.html')
    end
  end
end
