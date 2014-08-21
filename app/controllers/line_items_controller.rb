class CheckoutController < ApplicationController

  # добавляет товар в корзину
  def create
    product = Product.find(params[:product_id])
    line_item = current_cart.add_product(product.id)
    line_item.save
  end
  
  # удаляем товар из корзины
  def destroy
    line_item = LineItem.find(params[:id])
    line_item.destroy
  end

  # увеличиваем кол-во товаров
  def increase 
    line_item = LineItem.find(params[:id])
    line_item.quantity += 1
    line_item.save
  end
  
  # уменьшаем кол-во товаров
  def decrease 
    line_item = LineItem.find(params[:id])
    if line_item.quantity <= 1
      destroy
    else
      line_item.quantity -= 1
      line_item.save
    end
  end
  
end