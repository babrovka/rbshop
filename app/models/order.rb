# == Schema Information
#
# Table name: shop_orders
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  name       :string(255)
#  email      :string(255)
#  phone      :string(255)
#  city       :string(255)
#  address    :string(255)
#  comment    :text
#  status     :integer          default(0)
#  pay_type   :integer
#  total      :integer          default(0)
#

class Order < ActiveRecord::Base
  def self.table_name_prefix
    'shop_'
  end
  
  has_many :line_items,  dependent: :destroy
  belongs_to :user
  after_save :buy_products_in_line_items
  after_save :count_total
  after_save :update_user_bought_counter
  before_save :copy_user_info, :if => lambda {|order| order.user.present? }
  
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
    if self.delivered? && self.user
      user = self.user
      user_total = user.bought_counter.to_i
      total = user_total + self.total.to_i
      user.update_columns(bought_counter: total)
    end
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def count_total
    self.update_columns(total: total_price)
  end
  
  def discounted_price  
    if self.user
      percents = 100-self.user.discount
      discounted_price = self.total_price/100*percents
      discounted_price
    else
      self.total_price
    end
  end
  
  def copy_user_info  
    self.name = "#{self.user.first_name} #{self.user.last_name}"
  end
  
end
