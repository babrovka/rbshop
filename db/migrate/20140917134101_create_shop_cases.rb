class CreateShopCases < ActiveRecord::Migration
  def change
    create_table :shop_cases do |t|
      t.string   "title"
      t.text     "text"
      t.text     "short_description"
      t.attachment   "image"
      t.string   "slug"
      t.string   "seo_url"
      t.string   "seo_title"
      t.text     "seo_description"
      
      t.timestamps
    end
  end
end
