class ProductTaxon < ActiveRecord::Base
  self.table_name = "shop_product_taxons"
  
  belongs_to :product
  belongs_to :taxon
end
