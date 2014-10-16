class Admin::HintsController < Admin::ApplicationController
  layout 'admin/application'
  
  inherit_resources

  actions :index, :update

  def build_resource_params
    [params.fetch(:hint, {}).permit(
         :text,
         :id,
         :hint_type
     )]
  end


end