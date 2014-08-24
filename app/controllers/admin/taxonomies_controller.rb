class Admin::TaxonomiesController < Admin::ApplicationController
  layout 'admin/application'
  
  inherit_resources
  
  defaults resource_class: Taxonomy.friendly
  
  has_scope :page, default: 1, only: :index
  has_scope :per, default: 15, only: :index

  actions :index, :edit, :update


  def build_resource_params
    [params.fetch(:taxonomy, {}).permit(
         :title,
         :slug,
         :seo_title,
         :seo_description,
         :seo_text,
         :taxons_ids
     )]
  end

end