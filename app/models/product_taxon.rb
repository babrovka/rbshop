# == Schema Information
#
# Table name: shop_product_taxons
#
#  id         :integer          not null, primary key
#  product_id :integer
#  taxon_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class ProductTaxon < ActiveRecord::Base
  self.table_name = "shop_product_taxons"
  
  belongs_to :product
  belongs_to :taxon
end
