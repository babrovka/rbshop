class LineItem < ActiveRecord::Base
  def self.table_name_prefix
    'shop_'
  end
  
  belongs_to :product
  belongs_to :cart
  belongs_to :order
  
  def total_price
  	product.price * quantity
  end
end
