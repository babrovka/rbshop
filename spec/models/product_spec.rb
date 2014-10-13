# == Schema Information
#
# Table name: products
#
#  id                   :integer          not null, primary key
#  title                :string(255)
#  packing              :string(255)
#  text                 :text
#  ingredients          :text
#  brand_id             :integer
#  visible_professional :boolean          default(FALSE)
#  visible_dealer1      :boolean          default(FALSE)
#  visible_dealer2      :boolean          default(FALSE)
#  visible_dealer3      :boolean          default(FALSE)
#  price_professional   :decimal(8, 2)
#  price_dealer1        :decimal(8, 2)
#  price_dealer2        :decimal(8, 2)
#  price_dealer3        :decimal(8, 2)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  short_description    :text
#  product_category_id  :integer
#  latest               :boolean
#  slug                 :string(255)
#  seo_title            :string(255)
#  seo_description      :text
#  seo_text             :text
#  taxon_id             :integer
#  position             :integer          default(0)
#  sku                  :string(255)
#  price                :integer          default(0)
#  new_price            :integer
#  applying             :string(255)
#  in_stock             :boolean          default(TRUE)
#  bought               :integer          default(0)
#  product_type         :integer          default(0)
#  promo_id             :integer
#  promo_products_price :integer
#  show_in_slider       :boolean          default(FALSE)
#

require 'rails_helper'

describe Product do
  
  describe '#product' do
    let(:product) { create(:product) }
    
    context 'current_price' do
      it "is has no new price" do
        product.price = 100
        product.new_price = 0
        expect(product.current_price).to eq product.price
      end
      
      it "is has new price" do
        product.price = 100
        product.new_price = 200
        expect(product.current_price).to eq product.new_price
      end
    end
    
    context 'old_price' do
      it "is has price & new price" do
        product.price = 100
        product.new_price = 200
        expect(product.old_price).to eq product.price
      end
      
      it "is has price" do
        product.price = 1000
        expect(product.old_price).to eq product.price
      end
      
      it "is has no price" do
        product.price = 0
        expect(product.old_price).to be nil
      end
      
    end
    
    context 'bought' do
      it "by method" do
        n = rand(9..100)
        expect {product.buy(n)}.to change {product.bought}.by(n)
      end
      
      it "by order" do
        n = rand(9..100)
        l = LineItem.create(product_id: product.id, quantity: n)
        o = Order.new
        o.status = 'delivered'
        o.line_items << l
        o.save
        product.reload
        expect(product.bought).to eq n
      end
    end
    
  end
  
  
    
end
