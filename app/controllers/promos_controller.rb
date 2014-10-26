class PromosController < ApplicationController

  helper_method :resource,
                :collection

  def index
    Product.promos.order('position ASC')
  end


  def show
  end


end