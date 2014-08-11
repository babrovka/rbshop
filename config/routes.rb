Rails.application.routes.draw do
  
  namespace :admin do
    resources :products, :taxons, :taxonomies, except: [:show]
  end

  root 'pages#index'


end
