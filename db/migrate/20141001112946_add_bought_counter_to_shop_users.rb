class AddBoughtCounterToShopUsers < ActiveRecord::Migration
  def change
    add_column :shop_users, :bought_counter, :integer, default: 0  
    User.all.each(&:save)
  end
end
