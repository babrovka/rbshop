class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :title
      t.text :text
      t.attachment :image
      t.integer :product_id

      t.timestamps
    end
  end
end
