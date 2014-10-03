class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_cart

  private
  
  def seo_data(element)
    @seo_title = element.try(:seo_title) || ''
    @seo_description = element.try(:seo_description) || ''
    @seo_text = element.try(:seo_text) || ''
  end
  
  def temporary_cart
    cart = Cart.where(id: session[:cart_id]).first_or_create!
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
    if current_user
      current_user.cart = temporary_cart
      current_user.save
    end
  end
  
  def destroy_cart
    if current_user.cart
      current_user.cart.destroy
    end
  end
  
end
