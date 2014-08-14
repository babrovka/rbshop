class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.where(id: params[:id])
  end

end