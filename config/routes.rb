Rails.application.routes.draw do
  
  scope module: 'admin' do
    devise_for :admins, path: 'admin'
  end
  
  namespace :admin do
    resources :products, :taxons, :taxonomies, except: [:show]
  end

  root 'pages#index'


end
