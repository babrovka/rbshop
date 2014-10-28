class PromosController < ApplicationController

  helper_method :resource,
                :collection

  def index
    Product.promo.order('position ASC')
  end


  def show
  end


end