class LineItemsController < ApplicationController

  # добавляет товар в корзину
  # TODO-bobrovka: нужно расширить, если нужно добавить в корзину не 1 штуку, а разу 3-5 штук.
  def create
    product = Product.find(params[:product_id])
    line_item = current_cart.add_product(product.id)
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
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += 1
    @line_item.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'cart_line_item', layout: false }
    end
  end
  
  # уменьшаем кол-во товаров
  def decrease 
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity <= 1
      @line_item.quantity = 1
    else
      @line_item.quantity -= 1
      @line_item.save
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'cart_line_item', layout: false }
    end
  end
  
end