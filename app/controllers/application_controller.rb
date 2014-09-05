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

  def current_cart
    Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
  
end
