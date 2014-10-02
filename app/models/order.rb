class Order < ActiveRecord::Base
  def self.table_name_prefix
    'shop_'
  end
  
  has_many :line_items,  dependent: :destroy
  belongs_to :user
  after_save :buy_products_in_line_items
  after_save :count_total
  after_save :update_user_bought_counter
  
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
    if self.delivered?
      line_items.each do |line_item|
        line_item.product.buy(line_item.quantity) if line_item.product
      end
    end
  end
  
  def update_user_bought_counter
    if self.delivered?
      user = self.user
      user.update_columns(bought_counter: self.total)
    end
  end

  def count_total
    total = self.line_items.map {|l| l.total_price.to_i}.sum
    self.update_columns(total: total)
  end
  
end
