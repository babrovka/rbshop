# == Schema Information
#
# Table name: shop_line_items
#
#  id         :integer          not null, primary key
#  product_id :integer
#  cart_id    :integer
#  order_id   :integer
#  quantity   :integer          default(1)
#  created_at :datetime
#  updated_at :datetime
#

class LineItem < ActiveRecord::Base
  def self.table_name_prefix
    'shop_'
  end
  
  belongs_to :product
  belongs_to :cart
  belongs_to :order
  
  def total_price
  	product.price.to_i * quantity if product
  end
end
