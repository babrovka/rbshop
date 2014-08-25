class ChangePriceToProducts < ActiveRecord::Migration
  def change
    change_column :products, :price, :integer, default: 0
  end
end
