require 'rails_helper'

describe User do
  
  describe '#user' do
    let(:user) { create(:user) }
    let(:order) { create(:order, user: user) }
    let(:order_with_products1) { create(:order_with_products, user: user) }
    let(:order_with_products2) { create(:order_with_products, user: user) }
    
    context 'create order' do
      it "is possible" do
        expect {Order.create!(user_id: user.id)}.to change {user.orders.count}.by(1)
      end
    end
    
    context 'order products' do
      it "can be counted" do
        order1 = order_with_products1
        order1.status = 'delivered'
        order1.user = user
        order1.save!
        order2 = order_with_products2
        order2.status = 'delivered'
        order2.user = user
        order2.save!
        user.reload
        orders_total_price = order1.total + order2.total 
        expect(user.bought_counter).to eq orders_total_price
      end
    end
    
    context 'discount' do
      it "can be counted" do
        user.bought_counter = 150000
        user.save!
        user.reload 
        expect(user.discount).to eq 15
      end
    end
  end
  
  
    
end