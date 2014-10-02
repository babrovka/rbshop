require 'rails_helper'

describe Order do
  
  describe '#order' do
    let(:order) { create(:order) }
    let(:product1) { create(:product) }
    let(:product2) { create(:product) }
    let(:product3) { create(:product) }
    
    context 'total price' do
      it "can be counted" do
        price1 = product1.price
        price2 = product2.price
        price3 = product3.price
        l1 = LineItem.create(product_id: product1.id, quantity: 1)
        l2 = LineItem.create(product_id: product2.id, quantity: 1)
        l3 = LineItem.create(product_id: product3.id, quantity: 1)
        total = l1.total_price + l2.total_price + l3.total_price
        order.line_items << [l1, l2, l3]
        order.save
        order.reload
        expect(order.total).to eq total
      end
    end
  end
    
end