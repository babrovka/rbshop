class Admin::ProductsController < Admin::ApplicationController
  layout 'admin/application'
  
  inherit_resources
  
  defaults resource_class: Product.friendly
  
  has_scope :page, default: 1, only: :index
  has_scope :per, default: 15, only: :index

  actions :all, except: [:show]


  def build_resource_params
    [params.fetch(:product, {}).permit(
         :in_stock,
         :sku,
         :title,
         :short_description,
         :packing,
         :text,
         :ingredients,
         :brand,
         {taxon_ids: []},
         :price,
         :new_price,
         :latest,
         :slug,
         :seo_title,
         :seo_description,
         :seo_text
     )]
end


end