class ProductsController < ApplicationController

  helper_method :resource, :collection, :current_category
  
  def index
  end

  def show
  end
  
  def taxonomy
    taxon_ids = Taxon.where(taxonomy_id: selected_taxonomy.id).map(&:id)
    @products = Product.includes(:taxons).where(shop_taxons: { id: taxon_ids })
    # @products = @products.page(params[:page]).per_page(10)
    @title = selected_taxonomy.try(:seo_title) || ''
    @meta_description = selected_taxonomy.try(:seo_description) || ''
    @seo_text = selected_taxonomy.try(:seo_text) || ''
    session[:taxon_id] = nil
    render :template => '/products/index'
  end
  
  def taxon
    taxons = selected_taxon.self_and_descendants
    @products = Product.includes(:taxons).where(:shop_taxons => {:id => taxons})
    @products = @products.where(:brand_id => params[:brand_ids]) if params[:brand_ids]
    # @products = @products.page(params[:page]).per_page(10)
    @title = selected_taxon.seo_title
    @meta_description = selected_taxon.try(:seo_description) || ''
    @seo_text = selected_taxon.try(:seo_text) || ''
    render :template => '/products/index'
  end

  def resource
    @product ||= Product.friendly.find(params[:id])
  end

  def collection
    @products ||= Product.where(brand_id: params[:brand_ids])
    @products.page(params[:page]).per(20)
  end
  
  private

  
  def selected_taxon
    @selected_taxon ||= @taxon || Taxon.where(id: params[:id]).first
    session[:taxon_id] = @selected_taxon.try(:id)
    @selected_taxon
  end

  def selected_taxonomy
    @selected_taxonomy ||= @taxonomy || Taxonomy.where(slug: params[:id]).first
  end

  def current_category
    @current_category ||= selected_taxon.try(:title) || selected_taxonomy.try(:title) || 'Товары'
  end

end