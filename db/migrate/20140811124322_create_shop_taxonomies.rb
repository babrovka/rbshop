class CreateShopTaxonomies < ActiveRecord::Migration
  def change
    create_table :shop_taxonomies do |t|
      t.string   "title"
      t.string   "slug"
      t.string   "seo_title"
      t.text     "seo_description"
      t.text     "seo_text"
      t.timestamps
    end
  end
end
