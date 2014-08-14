class ProductsController < ApplicationController

  helper_method :resource, :collection

  def index
  end

  def show
  end

  def resource
    @product ||= Product.where(id: params[:id])
  end

  def collection
    @collection ||= Product.order('title ASC')
  end

end