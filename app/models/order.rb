class Order < ActiveRecord::Base
  def self.table_name_prefix
    'shop_'
  end
  
  has_many :line_items,  dependent: :destroy
  # belongs_to :user
  
  enum status: [ :not_paid, :paid, :ready_for_delivery, :delivered ]
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
