class Admin::ProductsController < Admin::ApplicationController
  inherit_resources

  actions :all, except: [:show]

end