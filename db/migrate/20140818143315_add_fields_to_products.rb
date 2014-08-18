class AddFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sku, :string
    add_column :products, :price, :integer
    add_column :products, :new_price, :integer
  end
end
