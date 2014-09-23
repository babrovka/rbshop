class CheckoutController < ApplicationController
  
  def cart
    @cart = current_cart
  end
  
  def checkout
    if current_cart.line_items.empty?
      redirect_to root_path, notice: 'Извините, ваша корзина пуста'
    else
      @order = Order.new
    end
  end
  
  def order
    @order = Order.create(order_params)
    @order.add_line_items_from_cart(current_cart)
    @order.city = 'Санкт-Петербург'
    @order.user_id = current_user.id
    
    if @order.save
      send_mails
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Заказ успешно создан, наши менеджеры свяжуться с вами' }
        format.js { render layout: false }
      end
    else
      redirect_to root_path, notice: 'Извините, что-то пошло не так'
    end
  end


  private
  
  def send_mails
    OrderMailer.delay.notify_client(@order)
    OrderMailer.delay.notify_admin(@order)
  end

  def order_params
    params.require(:order).permit(:name, :phone, :email, :address)
  end

end