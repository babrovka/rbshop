class Order < ActiveRecord::Base
  def self.table_name_prefix
    'shop_'
  end
  
  has_many :line_items,  dependent: :destroy
  belongs_to :user
  after_save :buy_products_in_line_items
  
  enum status: [ :not_paid, :paid, :ready_for_delivery, :delivered ]
  enum pay_type: [ :cash, :online ]
  
  default_scope { order('updated_at DESC') } 
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  
  def buy_products_in_line_items
    line_items.each do |line_item|
      line_item.product.buy(line_item.quantity)
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
