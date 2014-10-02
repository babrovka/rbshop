require 'rails_helper'

describe User do
  
  describe '#order' do
    let(:user) { create(:user) }
    let(:order) { create(:order, user: user) }
    let(:order_with_products) { create(:order_with_products, user: user) }
    
    context 'create order' do
      it "is possible" do
        expect {Order.create!(user_id: user.id)}.to change {user.orders.count}.by(1)
      end
    end
    
    context 'order products' do
      it "can be counted" do
        o = order_with_products
        o.status = 'delivered'
        o.user = user
        o.save!
        user.reload
        expect(user.bought_counter).to eq o.total
      end
    end
  end
  
  
    
end