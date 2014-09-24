class AddPromoIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :promo_id, :integer
  end
end
