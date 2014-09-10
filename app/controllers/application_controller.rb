class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_cart

  private
  
  def seo_data(element)
    @title = element.try(:seo_title) || ''
    @meta_description = element.try(:seo_description) || ''
    @seo_text = element.try(:seo_text) || ''
  end
  
  def temporary_cart
    cart = Cart.exists?(session[:cart_id]) ? Cart.where(id: session[:cart_id]).first : Cart.create
    session[:cart_id] = cart.id
    cart
  end
    
  def current_cart
    if current_user
      current_user.cart
    else
      temporary_cart
    end
  end
  
  def assign_cart_to_user
    authenticate_user!
    current_user.cart = temporary_cart
    current_user.save
  end
  
end
