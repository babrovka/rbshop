# == Schema Information
#
# Table name: shop_carts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Cart < ActiveRecord::Base
  def self.table_name_prefix
    'shop_'
  end
  
  belongs_to :user
  has_many :line_items, dependent: :destroy
  accepts_nested_attributes_for :line_items, allow_destroy: true


  def add_product(product_id, qty=1)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += qty.to_i
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end
  
  def total_price
    line_items.to_a.sum { |item| item.try(:total_price) || 0 }
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

  # кол-во всех единиц продукции с учетом того, что некоторых добавлено по 2-3 штуки
  def product_count
    line_items.to_a.sum { |item| item.quantity }
  end

  # кол-во уникальных товаров в корзине, будто каждых только по 1 штуке
  def items_count
    line_items.try(:count) || 0
  end

  def items
    line_items.order('created_at DESC')
  end


end
