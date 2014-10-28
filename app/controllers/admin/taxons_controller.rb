class Admin::TaxonsController < Admin::ApplicationController
  layout 'admin/application'
  
  inherit_resources
  
  defaults resource_class: Taxon.friendly
  
  has_scope :page, default: 1, only: :index
  has_scope :per, default: 15, only: :index
  has_scope :ordered, :default => 'updated_at DESC'

  actions :all, except: [:show]
  
  def new
    new! do |success|
      success.html { resource.build_case }
    end
  end

  def build_resource_params
    [params.fetch(:taxon, {}).permit(
         :title,
         :parent_id,
         :taxonomy_id,
         :taxon_type,
         :seo_title,
         :seo_description,
         :seo_text,
         :seo_url,
         {case_attributes: [
              :title,
              '_destroy'
          ]},
     )]
  end


end