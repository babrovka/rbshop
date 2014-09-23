class SessionsController < Devise::SessionsController
  after_action :assign_cart_to_user, only: [:create]
  before_action :destroy_cart, only: [:destroy]
end