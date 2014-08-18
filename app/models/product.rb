class Product < ActiveRecord::Base
  belongs_to :brand
  has_many :product_images
  has_many :product_taxons
  has_many :taxons, through: :product_taxons
  
  extend FriendlyId
  friendly_id :short_description, use: :slugged
end
