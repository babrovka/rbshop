Rails.application.routes.draw do
  
  scope module: 'admin' do
    devise_for :admins, path: 'admin'
  end
  
  namespace :admin do
    get '/' => 'products#index', :as => :root
    resources :products, except: [:show] do 
      collection do 
        get 'statistics'
      end
    end
    resources :taxons,
              :taxonomies,
              :cases,
              except: [:show]
    resources :orders, except: [:show] do
      collection do 
        get 'statistics'
      end
    end
  end
  
  # юзеры
  devise_for :users, :controllers => {:registrations => "registrations"}
  get '/personal' => 'users#personal'
  get '/orders' => 'users#orders'
  
  # управляем товарами в корзине
  resources :line_items, only: [:create, :destroy] do
    member do 
      get 'increase'
      get 'decrease'
    end
  end
  
  # смотрим корзину
  get '/cart' => 'checkout#cart', :as => :cart
  
  # заполняем форму для оформления заказа
  get '/checkout' => 'checkout#checkout', :as => :checkout
  
  # создаем заказ
  post '/order' => 'checkout#order', :as => :order
  
  # главная страница
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
