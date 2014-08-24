class Admin::OrdersController < Admin::ApplicationController
  layout 'admin/application'
  
  inherit_resources
  
  has_scope :page, default: 1, only: :index
  has_scope :per, default: 15, only: :index

  actions :index, :edit, :update

  def build_resource_params
    [params.fetch(:taxon, {}).permit(
         :name,
         :email,
         :phone,
         :city,
         :address,
         :comment,
     )]
  end


end