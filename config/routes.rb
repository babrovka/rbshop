Rails.application.routes.draw do
  
  namespace :admin do
    resources :products, :taxons, :taxonomies
  end

  root 'pages#index'


end
