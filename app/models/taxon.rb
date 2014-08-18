class Taxon < ActiveRecord::Base
  self.table_name = "shop_taxons"
  belongs_to :taxonomy
  has_many :product_taxons
  has_many :products, through: :product_taxons
  
  acts_as_nested_set
  default_scope { order('lft ASC') } 
  
  extend FriendlyId
  friendly_id :seo_url, use: :slugged
  
  enum taxon_type: [ :by_product_type, :by_care_type, :by_age ]
  
  scope :with_type, -> { where(taxon_type: nil) }
  
end
