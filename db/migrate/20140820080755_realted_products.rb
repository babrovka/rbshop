class RealtedProducts < ActiveRecord::Migration
  def change
    create_table :related_products, id: false do |t|
      t.integer   "product_id"
      t.integer   "related_product_id"
      t.timestamps
    end
  end
end
