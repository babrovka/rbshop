class Admin::CasesController < Admin::ApplicationController
  layout 'admin/application'
  
  inherit_resources
  
  defaults resource_class: Case.friendly
  
  has_scope :page, default: 1, only: :index
  has_scope :per, default: 15, only: :index

  actions :all, except: [:show]

  def build_resource_params
    [params.fetch(:case, {}).permit(
         :title,
         :text,
         :short_description,
         :image,
         :seo_url,
         :seo_title,
         :seo_description,
         product_ids: []
     )]
  end


end