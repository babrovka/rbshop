# == Schema Information
#
# Table name: shop_carts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Cart do
  
  describe '#cart' do
    let(:user) { create(:user) }
    let(:cart) { create(:cart_with_products, user: user) }
    
    context 'total_price' do
      it "can be discounted" do
        user.bought_counter = rand(1.9999999999)
        user.save!
        user.reload 
        cart.reload
        cart_total_price = cart.line_items.to_a.sum { |item| item.total_price }
        percents = 100-user.discount
        cart_discounted_price = cart_total_price/100*percents
        
        expect(cart.discounted_price).to eq cart_discounted_price
      end
    end
  end
    
end
