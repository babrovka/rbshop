class Taxon < ActiveRecord::Base
  self.table_name = "shop_taxons"
  belongs_to :taxonomy
  has_many :product_taxons
  has_many :products, through: :product_taxons
  
  acts_as_nested_set
  default_scope { order('lft ASC') } 
  
  extend FriendlyId
  friendly_id :seo_url, use: :slugged
end
