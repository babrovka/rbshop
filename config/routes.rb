Rails.application.routes.draw do
  
  scope module: 'admin' do
    devise_for :admins, path: 'admin'
  end
  
  namespace :admin do
    get '/' => 'products#index', :as => :root
    resources :products, :taxons, :taxonomies, except: [:show]
  end

  root 'pages#index'

  get 'menu', to: 'pages#menu'
  
  # products
  resources :products, only: [:index]
  # taxonomy
  get '/products/:id' => 'products#taxonomy', :as => :taxonomy
  #taxon
  get '/:taxonomy/:id', to: 'products#taxon', :as => :taxon
  # product
  get '/:id' => 'products#show', as: :product
end
