class AddInStockToProducts < ActiveRecord::Migration
  def change
    add_column :products, :in_stock, :boolean, default: true
    Product.update_all(in_stock: true)
  end
end
