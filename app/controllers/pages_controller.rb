class PagesController < ApplicationController

  def index
    @extra_header = true
    @extra_products = Product.limit 10
    @slides = Slide.for_allowed_products
  end

  def menu

  end

end