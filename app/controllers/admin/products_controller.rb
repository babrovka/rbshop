class Admin::ProductsController < Admin::ApplicationController
  layout 'admin/application'
  
  inherit_resources
  
  defaults resource_class: Product.friendly
  
  has_scope :page, default: 1, only: :index
  has_scope :per, default: 15, only: :index
  # has_scope :ordered, :default => 'updated_at DESC'

  actions :all, except: [:show]

  def index
    # т.к.в деве и продакшене разные поисковые механизмы
    # то приходится делать проверку на класс проверки
    @query = Product.ransack(params[:q])
    @products = @query.result(distinct: true)
    @products = apply_scopes(@products)
  end

  def edit
    session[:redirect_to_path] = request.referer
    edit!
  end


  def crop
  end


  def statistics
     @products = collection.order('bought DESC')
  end
  
private

  def collection_url
    path = session[:redirect_to_path]
    session[:redirect_to_path] = nil
    path || admin_products_path
  end
  
  def collection
    @products ||= end_of_association_chain.regular
  end
  
  def build_resource_params
    [params.fetch(:product, {}).permit(
         :in_stock,
         :sku,
         :title,
         :position,
         :short_description,
         :packing,
         :text,
         :ingredients,
         {taxon_ids: []},
         :price,
         :new_price,
         :latest,
         {related_product_ids: []},
         {same_taxon_product_ids: []},
         {product_images_attributes: [
             :image,
             :image_original_w,
             :image_original_h,
             :image_box_w,
             :image_crop_x,
             :image_crop_y,
             :image_crop_w,
             :image_crop_h,
             :image_aspect,
             :id,
             '_destroy'
         ]},
         :seo_title,
         :seo_description,
         :seo_text,
         :brand_id, 
         :applying, 
         {case_ids: []}
     )]
end

end