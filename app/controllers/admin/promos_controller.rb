class Admin::PromosController < Admin::ApplicationController
  layout 'admin/application'
  
  inherit_resources
  
  defaults resource_class: Product.friendly, :collection_name => 'promos', :instance_name => 'promo'
  
  has_scope :page, default: 1, only: [:index]
  has_scope :per, default: 15, only: [:index]
  has_scope :ordered, :default => 'created_at DESC'
  
  helper_method :collection_form_url
  
  actions :all, except: [:show]
  
  def new
    new! do |success|
      success.html { resource.build_slide }
    end
  end

  def crop
  end


  private
  
  def root_url
    admin_promos_path
  end
  
  def collection_form_url
    if resource.new_record?
      admin_promos_path
    else
      admin_promo_path(resource)
    end
  end

  def collection
    @promos ||= end_of_association_chain.promo
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
         { taxon_ids: [] },
         :price,
         :new_price,
         :latest,
         { related_product_ids: [] },
         { same_taxon_product_ids: [] },
         { product_images_attributes: [
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
         ] },
         :seo_title,
         :seo_description,
         :seo_text,
         :brand_id,
         :applying,
         { case_ids: [] },
        :product_type,
        {product_ids: []},
        :show_in_slider,
        {slide_attributes: [
             :title,
             :text,
             :image,
             :id,
             '_destroy'
         ]},
     ).merge(product_type: 'promo')]
   end


end