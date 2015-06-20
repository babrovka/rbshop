class PromosController < ApplicationController

  helper_method :resource,
                :collection

  def index
  end


  def show
  end

private

  # инстанс для поддержки гибкой фильтрации
  def filter
    @q ||= Product.promo.in_stock.ransack(search_params)
  end

  # подготовка параметров к фильтрации
  def search_params
    @search_params ||= params.fetch(:q, {}).permit(:s)
  end

  # коллеция акций
  def collection
    @promos ||= filter.result(distinct: true)
                      .order('position ASC')
                      .page(params[:page])
                      .per(params[:per] || 20)
  end

  def resource
    @promo ||= Product.promo.friendly.find(params[:id])
  end


end