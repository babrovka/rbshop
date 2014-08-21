class SameTaxonProducts < ActiveRecord::Migration
  def change
    create_table :same_taxon_products, id: false do |t|
      t.integer   "product_id"
      t.integer   "same_product_id"
      t.timestamps
    end
  end
end
