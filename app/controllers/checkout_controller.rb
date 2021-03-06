class CheckoutController < ApplicationController
  
  def cart
    @cart = current_cart
  end
  
  def checkout
    if current_cart.line_items.empty?
      redirect_to root_path, notice: 'Извините, ваша корзина пуста'
    else
      @order = Order.new
      build_order_for_current_user
    end
  end
  
  def order
    @order = Order.create(order_params)
    @order.add_line_items_from_cart(current_cart)
    @order.city = 'Санкт-Петербург'
    if user_signed_in?
      @order.user_id = current_user.id
    end
    
    if @order.save
      send_mails
      current_cart.line_items.clear
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

  def build_order_for_current_user
    if current_user
      @order.user = current_user
      @order.copy_user_info
      @order.email = current_user.email
      @order.phone = current_user.phone
      @order.address = current_user.address
    end
  end

end