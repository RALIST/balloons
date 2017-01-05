Rails.application.routes.draw do

  namespace :delivery do
    root 'main#index'
  end

  namespace :shop do
    root 'main#index'
  end
 
end