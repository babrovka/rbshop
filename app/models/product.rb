class Product < ActiveRecord::Base
  belongs_to :brand
  has_many :product_images
  has_many :product_taxons
  has_many :taxons, through: :product_taxons
end
