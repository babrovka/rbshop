class PagesController < ApplicationController

  def index
    @extra_header = true
    @extra_products = Product.limit 10
  end

  def product
    render 'products/show'
  end

end