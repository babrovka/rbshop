class Admin::TaxonsController < Admin::ApplicationController
  layout 'admin/application'
  
  inherit_resources
  
  defaults resource_class: Taxon.friendly
  
  has_scope :page, default: 1, only: :index
  has_scope :per, default: 15, only: :index

  actions :all, except: [:show]

  def build_resource_params
    [params.fetch(:taxon, {}).permit(
         :title,
         :parent_id,
         :taxonomy_id,
         :taxon_type,
         :slug,
         :seo_title,
         :seo_description,
         :seo_text,
         :seo_url
     )]
  end


end