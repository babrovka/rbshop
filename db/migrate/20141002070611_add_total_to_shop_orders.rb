class AddTotalToShopOrders < ActiveRecord::Migration
  def change
    add_column :shop_orders, :total, :integer, default: 0
  end
end
