class LineItemsController < ApplicationController

  # добавляет товар в корзину
  def create
    product = Product.find(params[:product_id])
    line_item = current_cart.add_product(product.id, params[:count] || 1)
    line_item.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js{ render layout: false }
    end
  end
  
  # удаляем товар из корзины
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render layout: false }
    end
  end

  # увеличиваем кол-во товаров
  def increase
    qty = params[:qty] || 1
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += qty
    @line_item.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'cart_line_item', layout: false }
    end
  end
  
  # уменьшаем кол-во товаров
  def decrease
    qty = params[:qty] || 1
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity <= qty
      @line_item.quantity = 1
    else
      @line_item.quantity -= qty
      @line_item.save
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'cart_line_item', layout: false }
    end
  end
  
end