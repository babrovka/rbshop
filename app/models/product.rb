class Product < ActiveRecord::Base
  belongs_to :brand
  has_many :product_images
end
