class AddPromoProductsPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :promo_products_price, :integer
  end
end
