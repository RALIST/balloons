Rails.application.routes.draw do

  root 'delivery/main#index'

  namespace :delivery do
    root 'main#index'
    resources :items, only: [:index, :show]
    resources :compositions, only: [:index, :show]
  end

  namespace :shop do
    root 'main#index'
  end

  namespace :admin do
    root 'main#index'
    resources :items
    resources :compositions
  end
 
end