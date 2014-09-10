class RegistrationsController < Devise::RegistrationsController
  after_action :assign_cart_to_user, only: [:create]
end