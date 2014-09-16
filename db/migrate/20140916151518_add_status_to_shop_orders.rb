class AddStatusToShopOrders < ActiveRecord::Migration
  def change
    add_column :shop_orders, :status, :integer, default: 0
  end
end
