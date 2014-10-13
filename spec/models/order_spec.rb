require 'rails_helper'

describe Order do
  
  describe '#order' do
    let(:order) { create(:order) }
    let(:user) { create(:user) }
    let(:product1) { create(:product) }
    let(:product2) { create(:product) }
    let(:product3) { create(:product) }
    
    let(:user) { create(:user) }
    let(:order) { create(:order_with_products, user: user) }
    
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
    
    context 'total_price' do
      it "can be discounted" do
        user.bought_counter = 150000
        user.save!
        user.reload 
        order.reload
        order_total_price = order.line_items.to_a.sum { |item| item.total_price }
        percents = 100-user.discount
        order_discounted_price = order_total_price/100*percents
        
        expect(order.discounted_price).to eq order_discounted_price
      end
    end
    
  end
    
end