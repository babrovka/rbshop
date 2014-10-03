class AddFieldsToShopUsers < ActiveRecord::Migration
  def change
    add_column :shop_users, :name, :string
    add_column :shop_users, :phone, :string
    add_column :shop_users, :city, :string
    add_column :shop_users, :address, :string
  end
end
