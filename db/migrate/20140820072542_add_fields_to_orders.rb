class AddFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :shop_orders, :user_id, :integer
    add_column :shop_orders, :name, :string
    add_column :shop_orders, :email, :string
    add_column :shop_orders, :phone, :string
    add_column :shop_orders, :city, :string
    add_column :shop_orders, :address, :string
    add_column :shop_orders, :comment, :text
  end
end
