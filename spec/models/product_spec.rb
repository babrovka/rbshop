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