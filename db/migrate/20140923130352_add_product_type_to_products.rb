class AddProductTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_type, :integer, default: 0
    Product.all.each do |product|
      product.product_type = 0
      product.save
    end
  end
end
