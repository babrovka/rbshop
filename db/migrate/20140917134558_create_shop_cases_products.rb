class CreateShopCasesProducts < ActiveRecord::Migration
  def change
    create_table :shop_cases_products, id: false do |t|
      t.integer :product_id
      t.integer :case_id
    end
  end
end
