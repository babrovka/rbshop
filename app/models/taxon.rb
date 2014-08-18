class Taxon < ActiveRecord::Base
  self.table_name = "shop_taxons"
  
  has_many :product_taxons
  has_many :products, through: :product_taxons
end
