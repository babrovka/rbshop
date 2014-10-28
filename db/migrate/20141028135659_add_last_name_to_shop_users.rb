class AddLastNameToShopUsers < ActiveRecord::Migration
  def change
    add_column :shop_users, :last_name, :string
    rename_column :shop_users, :name, :first_name
  end
end
