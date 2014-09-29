class Product < ActiveRecord::Base
  belongs_to :brand
  has_many :product_images
  has_many :product_taxons
  has_many :taxons, through: :product_taxons
  # has_and_belongs_to_many :procedures
  has_and_belongs_to_many :cases, join_table: "shop_cases_products"
  has_and_belongs_to_many :related_products,
                          class_name: 'Product',
                          join_table: "related_products",
                          foreign_key: "product_id",
                          association_foreign_key: "related_product_id"
  has_and_belongs_to_many :same_taxon_products,
                          class_name: 'Product',
                          join_table: "same_taxon_products",
                          foreign_key: "product_id",
                          association_foreign_key: "same_product_id"                          
  belongs_to :promo, class_name: "Product"
  has_many :products, class_name: "Product",
                      foreign_key: "promo_id"
                      
  after_save :count_separate_product_price, :if => lambda {|product| product.product_type == 'promo' }
                      
  scope :in_stock, -> { where(in_stock: true) }
  scope :ordered, -> (field) {order(field)}
  
  enum product_type: [ :regular, :promo ]

  accepts_nested_attributes_for :product_images, allow_destroy: true
  
  extend FriendlyId
  friendly_id :short_description, use: :slugged
  
  def count_separate_product_price
    price = self.products.map {|p| p.price.to_i}.sum
    self.update_columns(promo_products_price: price)
  end
  
  def current_price
    unless new_price.nil? || new_price.zero?
      new_price
    else
      price
    end
  end
  
  def old_price
    if price
      price
    else
      nil
    end
  end
  
  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end

  def discount?
    if new_price
      true 
    else
      false
    end
  end
  
  def buy(quantity)
    self.bought += quantity
    self.save!
  end
end
