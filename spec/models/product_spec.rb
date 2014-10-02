require 'rails_helper'

describe Product do
  
  describe '#product' do
    let(:product) { create(:product) }
    
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