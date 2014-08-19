class PagesController < ApplicationController

  def index
    @extra_header = true
    @extra_products = Product.limit 10
  end

  def menu

  end

end