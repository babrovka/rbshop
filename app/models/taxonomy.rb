class Taxonomy < ActiveRecord::Base
  self.table_name = "shop_taxonomies"
  has_many :taxons
  
  extend FriendlyId
  friendly_id :title, use: :slugged
end
