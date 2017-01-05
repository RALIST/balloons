Rails.application.routes.draw do

  root 'delivery/main#index'

  namespace :delivery do
    root 'main#index'
  end

  namespace :shop do
    root 'main#index'
  end

  namespace :admin do
    root 'main#index'
  end
 
end