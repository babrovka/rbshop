class Admin::ProductsController < Admin::ApplicationController
  layout 'admin/application'
  
  inherit_resources
  
  defaults resource_class: Product.friendly
  
  has_scope :page, default: 1, only: [:index, :promo]
  has_scope :per, default: 15, only: [:index, :promo]
  has_scope :ordered, :default => 'updated_at DESC'

  actions :all, except: [:show]

  def index
    @products = apply_scopes(collection)
  end

  def create
    create! do |success, failure|
      if build_resource_params.first[:product_images_attributes].present?
        success.html{ redirect_to crop_admin_product_path(resource) }
      end
    end
  end

  def update
    update! do |success, failure|
      if build_resource_params.first[:product_images_attributes].present?
        success.html{ redirect_to crop_admin_product_path(resource) }
      end
    end
  end

  def crop
  end


  def statistics
     @products = collection.order('bought DESC')
  end
  
  def promo
    @products = collection.promo
    render :index
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
         :brand,
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
         :seo_text
     )]
end


end