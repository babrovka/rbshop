class ProductsController < ApplicationController

  helper_method :resource, :collection

  def index
  end

  def show
  end

  def resource
    @product ||= Product.where(id: params[:id]).first
  end

  def collection
    @collection ||= Product.order('title ASC').limit(20)
  end

end