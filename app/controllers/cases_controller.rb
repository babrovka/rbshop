class CasesController < ApplicationController

  helper_method :resource,
                :collection,
                :products

  def index
    if _case = Case.first
      redirect_to case_path(_case)
      return
    end
  end


  def show
    products
  end

private

  # инстанс для поддержки гибкой фильтрации
  def products_filter
    @q ||= resource.products.in_stock.ransack(search_params)
  end

  # подготовка параметров к фильтрации
  def search_params
    @search_params ||= params.fetch(:q, {}).permit(:s)
  end

  # коллеция cлучаев
  def collection
    # @promos ||= filter.result(distinct: true)
    #                   .order('position ASC')
    #                   .page(params[:page])
    #                   .per(params[:per] || 20)
  end

  def resource
    @case ||= Case.friendly.find(params[:id])
  end

  def products
    @products = products_filter.result(distinct: true)
                    .page(params[:page])
                    .per(params[:per] || 20)
  end


end