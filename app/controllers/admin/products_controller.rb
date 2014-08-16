class Admin::ProductsController < Admin::ApplicationController
  inherit_resources

  has_scope :page, default: 1, only: :index
  has_scope :per, default: 15, only: :index

  actions :all, except: [:show]


end