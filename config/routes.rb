Rails.application.routes.draw do
  
  # Admin area
  scope module: 'admin' do
    devise_for :admins, path: 'admin'
  end

  namespace :admin do
    get '/' => 'products#index', :as => :root
    resources :products, except: [:show] do 
      collection do 
        get 'statistics'
      end
      member do
        get 'crop'
      end
    end
    resources :promos, except: [:show] do
      member do
        get 'crop'
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

    resources :hints, only: [:index, :update]
  end
  # ===========================================================================


  # Regular users area
  devise_for :users, :controllers => {:registrations => 'registrations', :sessions => 'sessions'}
  get '/profile' => 'users#personal', as: :user_profile
  put '/profile' => 'users#update', as: :user
  get '/orders' => 'users#orders', as: :user_orders
  get '/bonus' => 'users#bonus', as: :user_bonus
  # ===========================================================================

  # Корзина и оформление заказа
  #
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
  # ===========================================================================


  # Simple pages
  root 'pages#index'
  %w(faq payments delivery returns how-to-buy).each do |page|
    get page => 'high_voltage/pages#show', id: page
  end
  # ===========================================================================


  resources :promos, only: [:show, :index]
  resources :cases, only: [:index, :show]

  # Friendly urls area
  # products
  resources :products, only: [:index]
  match :filter, to: 'products#filter', via: [:get, :post]
  # taxonomy
  get '/products/:id' => 'products#taxonomy', :as => :taxonomy
  #taxon
  get '/:taxonomy/:taxon', to: 'products#taxon', :as => :taxon
  # product
  get '/:id' => 'products#show', as: :product
  # ===========================================================================
end
