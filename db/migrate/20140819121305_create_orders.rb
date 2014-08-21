class CreateOrders < ActiveRecord::Migration
  def change
    create_table :shop_orders do |t|

      t.timestamps
    end
  end
end
