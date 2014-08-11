class CreateShopTaxons < ActiveRecord::Migration
  def change
    create_table :shop_taxons do |t|
      t.string   "title"
      t.integer  "taxonomy_id"
      t.integer  "parent_id"
      t.integer  "lft"
      t.integer  "rgt"
      t.integer  "depth"
      t.string   "slug"
      t.string   "seo_title"
      t.text     "seo_description"
      t.text     "seo_text"
      t.string   "seo_url"
      t.timestamps
    end
  end
end
