class PagesController < ApplicationController

  def index
    @extra_header = true
  end

  def product
    render 'products/show'
  end

end