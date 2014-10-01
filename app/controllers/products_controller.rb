class ProductsController < ApplicationController

  helper_method :resource,
                :collection,
                :current_category,
                :filter,
                :selected_taxon,
                :selected_taxonomy


  before_action :modify_search_params
  
  has_scope :ordered, :default => 'position ASC'

  def index
    render_responce
  end

  def show
    @related_products = resource.related_products
    @current_category = resource.same_taxon_products
  end
  
  def taxonomy
    taxon_ids = selected_taxonomy.taxons.pluck(:id)
    @products = collection.includes(:taxons).where(shop_taxons: { id: taxon_ids })
    seo_data(selected_taxonomy)
    render_responce
  end
  
  def taxon
    taxons = selected_taxon.self_and_descendants
    logger.info '####'
    logger.info filter.inspect
    logger.info collection.to_sql
    logger.info '####'
    @products = collection.includes(:taxons).where(:shop_taxons => {:id => taxons})
    seo_data(selected_taxon)
    render_responce
  end

private

  # рендеринг результата
  def render_responce
    respond_to do |format|
      format.html { render :index }
      format.json do
        txt = Russian.p(collection.count, 'товар', 'товара', 'товаров')
        render json: { text: "Найдено #{collection.total_count} #{txt}" }
      end
    end
  end

  def resource
    @product ||= Product.friendly.find(params[:id])
  end

  # инстанс для поддержки гибкой фильтрации
  def filter
    @q ||= Product.search(search_params)
  end

  # подготовка параметров к фильтрации
  def search_params
    @search_params ||= params.fetch(:q, {}).permit(
                            :price_gteq,
                            :price_lteq,
                            :new_price_lteq,
                            :new_price_gteq,
                            :new_price_or_price_lteq,
                            :new_price_or_price_gteq,
                            :s,
                            { taxons_id_in: [] },
                            { brand_id_in: [] },
                        )
  end


  # модифицируем параметры фильтрации перед построением самого ransack фильтра
  # здесь модифицируются все параметры, которые необходимо отразить визуально в фильтре
  def modify_search_params
    if params[:brand_ids].present?
      search_params.merge!(brand_id_in: params[:brand_ids])
    end
  end

  # коллеция товаров
  # унаследована от инстанса фильтрации
  # чтобы учитывать гибкие параметры фильтрации на различных страницах
  def collection
    # params[:brand_ids] ||= Brand.pluck(:id) unless params[:brand_ids].present?
    @products ||= filter.result(distinct: true)
                        .page(params[:page])
                        .per(params[:per] || 20)
  end

  def selected_taxon
    @selected_taxon ||= @taxon || Taxon.where(id: params[:id]).first
  end

  def selected_taxonomy
    @selected_taxonomy ||=  Taxonomy.where(slug: params[:id]).first ||
                            Taxonomy.where(slug: params[:taxonomy]).first ||
                            Taxonomy.where(id: params[:id]).first ||
                            Taxonomy.where(id: params[:taxonomy]).first
  end

  def current_category
    @current_category ||= selected_taxon.try(:title) || selected_taxonomy.try(:title) || 'Товары'
  end

end